# Basic Ext 9001

I've been looking into how to write ruby c extensions lately, so I want make an extension gem that I can experiment on. That's what this is.

## Questions

q: Can you set ruby instance variable on an object that's allocated as T_DATA? If so, where are the object's instance variables stored?

a: Yeah, you can set instance variables. I don't know where they would be stored, since every field in the T_DATA struct is used for something other than instance variables.