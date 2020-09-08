# Exercises for The Object Model

## 1. How do we create an object in Ruby? Give an example of the creation of an object.

To create a new object we first need to create a new class and then instantiate the object using the built-in `new` method:

```ruby
class Bird
end

polly = Bird.new
```

## 2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

A module is a collection of behaviors that we can "mixin" to any number of classes using the `include` keyword. Its purpose is to provided added functionality to the classes they are mixed in with.

```ruby
module Squawk
  def squawk
    puts "squawk!"
  end
end

class NewClass
  include Squawk
end
```
