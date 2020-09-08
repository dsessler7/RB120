# Lesson 4: Practice Problems: Easy 1

## Q1

All four options are objects. You can find out their class by calling the `#class` method on them.

## Q2

We can give those classes the ability to `go_fast` by adding the `include Speed` line to their class definitions. You can check by calling the method on an instance of the class.

## Q3

This is done via the `self.class` code, which calls the `#class` method on the calling object via the `self` keyword. The result is turned into a string via string interpolation.

## Q4

We would use the `::new` class method to create a new instance of the class.

## Q5

The `Pizza` class has an instance variable because instance variables start with one `@` symbol and are initialized in an instance method and `@name` in the `Pizza` class meets these requirements.

## Q6

We could manually write a getter instance method like this:

```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end

  def volume
    @volume
  end
end
```

Or we could just add an `attr_reader` statement to the class:

```ruby
class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end
```

## Q7

The default return value of calling `to_s` on an object is the object's class and its object id.

Check the documentation.

## Q8

The `self` refers to the calling object instance. It is necessary to call the setter instance method because without it, Ruby will just think we are initializing a new local variable.

## Q9

In this context, the `self` refers to the class `Cat` since it contains that method. It defines the method as a "class method".

## Q10

You would call `Bag.new(color, material)` and the two arguments would be necessary.
