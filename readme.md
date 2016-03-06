# Basic Ext 9001

I've been looking into how to write ruby c extensions lately, so I want make an extension gem that I can experiment on. That's what this is.

## Questions

q: Can you set ruby instance variable on an object that's allocated as T_DATA? If so, where are the object's instance variables stored?

a: Yeah, you can set instance variables. I don't know where they would be stored, since every field in the T_DATA struct is used for something other than instance variables.

q: What happens if you return Qundef from a method?

In the ruby interpreter, there are several 'special constants': Fixnums, internal Symbols, Qfalse, Qtrue, Qnil, and Qundef. Although Qundef exists, it doesn't seem to be accessible from ruby code. I'l try returning it from a method.

a: So, returning it turns out that no method should ever return Qundef. If the interpreter sees a return value of Qundef from a cfunc, it assumes there's a core bug and it pukes out a huge bug report.

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