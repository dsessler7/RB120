# Lesson 4: Practice Problems: Easy 3:

## Q1

### case 1

It will print "Hello".

### case 2

You will get a 'NoMethodError'.

### case 3

You will get an error complaining about not having enough arguments.

### case 4

It will print "Goodbye".

### case 5

You will get a 'NoMethodError'.

## Q2

You could fix it by either changing the `def hi` method to `def self.hi` or leaving the existing method as is and adding a `def self.hi` class method separately.

Either way, the `self.hi` method would have to then create a new `Greeting` object and call `greet` on it OR you would have to change the `greet` method in the `Greeting` class to be a class method as well (`self.greet`).

## Q3

Initialize two separate variables using `AngryCat.new` and be sure to give each a name and an age.

## Q4

```ruby
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat."
  end
end
```

## Q5

The code on line 2 will yield a NoMethodError since the method is a class method and the code is trying to call it like an instance method.

The code on line 3 will execute the `model` "method logic".

The code on line 5 will execute the `self.manufacturer` "method logic".

The code on line 6 will yield a NoMethodError since the method is an instance method and the code is trying to call it like a class method.

## Q6

We could instead write the code on line 10 like: `@age += 1`

## Q7

The `@brightness` and `@color` instance variables are initialized when a `Light` object is created, but are not used when the `information` method is called.

Also the `return` keyword on line 10 is not needed.
