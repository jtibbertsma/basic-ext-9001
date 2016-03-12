# Basic Ext 9001

I've been looking into how to write ruby c extensions lately, so I want make an extension gem that I can experiment on. That's what this is.

## Questions

q: Can you set ruby instance variable on an object that's allocated as T_DATA? If so, where are the object's instance variables stored?

a: Yeah, you can set instance variables. Normal Ruby objects (whose underlying c struct is T_OBJECT) each have their own hash table used to store instance variables. T_DATA objects don't have a hash table to store instance variables, but you can still set instance variables. It seems that there is a pointer to an instance variable hash table in the T_CLASS struct. This brings us to the next question:

q: Considering that T_DATA objects use the class hash table to store instance variables, is it possible to set different instance variable values on the same instance variable for multiple objects?

a: Even though it seems that T_DATA objects use the same hash table (from the class) to store ivars, it is still possible to have different ivar values on multiple objects.

It turns out that the values in the class ivar table are themselves hash tables. So to find instance variables on T_DATA objects, the vm has to do two hash lookups. But really, there's no reason to store generic ivars on T_DATA objects. Just define all your messages in C if you're going to bother to write C extensions.

Interestingly, it isn't possible to store ivars on special contants by monkey patching:

```ruby
class Fixnum
  def some_message
    @var = 69
  end

  def another_message
    @var
  end
end

32.some_message
```

The above code raises this error:

```
RuntimeError: can't modify frozen Fixnum
```

(all special constants are frozen)

q: What happens if you return Qundef from a method?

In the ruby interpreter, there are several 'special constants': Fixnums, internal Symbols, Qfalse, Qtrue, Qnil, and Qundef. Although Qundef exists, it doesn't seem to be accessible from ruby code. I'l try returning it from a method.

a: So, it turns out that no method should ever return Qundef. If the interpreter sees a return value of Qundef from a cfunc, it assumes there's a core bug and it pukes out a huge bug report.

Incidentally, undef actually <i>is</i> a keyword in Ruby, but it means something completely different.

```ruby
class Klass
  def method
    :something
  end

  undef method
end

k = Klass.new
k.method
```

The above code raises this error:

```
NoMethodError: undefined method `method' for #<Klass:0x007fd32153e318>
```