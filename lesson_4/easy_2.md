# Lesson 4: Practice Problems: Easy 2:

## Q1

It will be "You will " plus one of the three strings in the array in the choices method.

## Q2

It will be "You will " plus on of the strings in the array in the choices method defined in the RoadTrip class.

## Q3

Ruby will look for the method in the method lookup path which can be displayed by calling `#ancestors` on a class.

## Q4

You could add `attr_accessor :type` to the class and remove the `#type` and `#type=` instance method definitions.

## Q5

The `excited_dog` var is a local variable. We know this because it doesn't have a `@` and it is in `snake_case` formatting so it isn't a constant.

The `@excited_dog` var is an instance variable (or it could be a class instance variable depending on where it is initialized). We know this because it has one `@` at the front.

The `@@excited_dog` var is a class variable. We know this because it has two `@@` at the front.

## Q6

The `self.manufacturer` method is a class method. We know this because it has `self` at the beginning of the name. You would call it on the class like "Television.manufacturer".

## Q7

The `@@cats_count` variable is a class variable. It is initialized at the class level which essentially means it is available as soon as the program containing this code is run. It is incremented whenever a `Cat` object is initialized and therefore counts the number of `Cat` objects that have been created. Here is code that would test this theory:

```ruby
lily = Cat.new('calico')
puts Cat.cats_count            # => 1
leo = Cat.new('tabby')
puts Cat.cats_count            # => 2
```

## Q8

We can add ` < Game` to the `class Bingo` line so that `Bingo` becomes a sub-class of `Game` and therefore inherits the `play` method.

## Q9

Whenever the `play` method would be called on a `Bingo` object, it would use the `play` method defined in the `Bingo` class rather than the one in the `Game` class.

## Q10

Benefits of using OOP in Ruby:

* DRY - Do not Repeat Yourself - with OOP you can write functionality into classes and modules and easily use them over and over again rather than re-writing the code many times over
* Namespacing - organize code in a way where the naming gives you context clues as to the objects behaviors, states, and inheritance from other classes
* polymorphism - write code so that you can use the same methods with many different objects
* encapsulation - only give the user access to what you want them to have or what they need
* inheritance - write classes in a hierarchical structure so that you can build off of code already written so that it uses functionality already there but allows for specialization in writing new methods or overwriting already existing methods
