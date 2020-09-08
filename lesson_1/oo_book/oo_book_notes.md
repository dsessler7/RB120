# Object Oriented Programming

## The Object Model

### Some OOP terms to start

* Object Oriented Programming (OOP) - a programming paradigm that was created to deal with the growing complexity of large software systems
* Encapsulation - hiding pieces of functionality and making it unavailable to the rest of the code base. Works to protect data so it cannot be changed without obvious intent
* Polymorphism - the ability for different types of data to respond to a common interface. Essentially, it lets objects of different types respond to the same method invocation
* Inheritance - a class will inherit he behaviours of it's parent class or superclass
* Module - similar to classes in that they contain shared behavior, but you cannot create an object with a module. Modules must be mixed in with a class using `include`
* Mixin - process of mixing in a module with a class so that the behaviors declared in that module are available to the class and its objects

### What are objects?

Some say in Ruby that everything is an object, but that is not entirely true. Two examples of non-objects are blocks and methods.

Objects are created from classes. Classes are like molds and objects the things you create from those molds.

### Classes Define Objects

Defining a class is similar to defining a method, but we replace `def` with `class` and use CamelCase instead of snake_case:

```ruby
class GoodDog
end

sparky = GoodDog.new
```

### Modules

A module is a collection of behaviors that is usable in other classes via mixins. A module is "mixed in" to a class using the `include` method invocation. So if we wanted our `GoodDog` class to have a `speak` method, but we wanted other classes to be able to use this method as well, we can use a module:

```ruby
module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak('Arf!')
bob = HumanBeing.new
bob.speak('Hello!')
```

### Method Lookup

When you call a method, Ruby has a distinct lookup path that it follows to find the method. We can use the `ancestors` method on any class to find out the method lookup chain.

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors

# The output looks like this:

# ---GoodDog ancestors---
# GoodDog
# Speak
# Object
# Kernel
# BasicObject

# ---HumanBeing ancestors---
# HumanBeing
# Speak
# Object
# Kernel
# BasicObject
```

The `Speak` module is placed right in between our custom classes and the `Object` class that comes with Ruby. So basically, when `speak` is called, it first looks in the class of the object that is calling it, then any mixed in modules, then down the chain of parent classes of the object class (in this case `Object` then `Kernel` then `BasicObject`).

## Classes and Objects - Part I

### States and Behaviors

States track attributes for individual objects. Behaviors are what objects are capable of doing.

Instance variables are scoped at the object (or instance) level and are how objects keep track of their states. Instance methods defined in a class are how we define behaviors for that class.

### Initializing a New Object

Continuing with our `GoodDog` example but starting fresh:

```ruby
class GoodDog
  def initialize
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new      # => "This object was initialized!"
```

The `initialize` method gets called every time you create a new object. So even when you call the `new` method to create an object, it also calls the `initialize` instance method. We refer to the `initialize` method as a *constructor* because it gets triggered whenever we create a new object.

### Instance Variables

Let's create a new object and instantiate it with some state, like a name:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end
```

The `@` symbol at the beginning of the `@name` variable denotes it as an **instance variable**. It is a variable that exists as long as the object instance exists and is one way we tie data to objects. You can pass arguments into the `initialize` method through the `new` method

```ruby
sparky = GoodDog.new("Sparky")
```

### Instance Variables

Let's give our `GoodDog` class some behaviors:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak           # => Arf!

fido = GoodDog.new("Fido")
puts fido.speak             # => Arf!
```

Both `GoodDog` objects can perform `GoodDog` behaviors. All objects of the same class have the same behaviors though they they contain different states.

If we wanted to not just say "Arf!" but "Sparky says arf!", we could adjust our `speak` instance method to reference the `@name` instance variable like so:

```ruby
def speak
  "#{@name} says arf!"
end
```

### Accessor Methods

What if we wnated to print out only `sparky`'s name? We could try the below:

```ruby
puts sparky.name

# => NoMethodError: undefined method `name' for #<GoodDog:0x007f91821239d0 @name="Sparky">
```

But as we can see, that won't work. If we want to access the object's name which is stored in the `@name` instance variable, we have to create a method that will return the name. Let's call it `get_name` and its only job will be to return the value in the `@name` instance variable:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak                 # => Sparky says arf!
puts sparky.get_name              # => Sparky
```

This is called a *getter* method. What if we wanted to change `sparky`'s name? That's when we need a *setter* method.  We would add the following to the `GoodDog` class:

```ruby
def set_name=(name)
  @name = name
end
```

And can be used like so:

```ruby
sparky.set_name = "Spartacus"
puts sparky.get_name              # => Spartacus
```

It is important to note that we are calling the `set_name=` method and that normally we would format this like `sparky.set_name=("Spartacus")` but Ruby recognizes that this is a *setter* method and allows us to use the more natural assignment syntax: `sparky.set_name = "Spartacus"`. Another example of Ruby's *syntactical sugar*.

Finally, as a convention, Rubyists typically name the *setter* and *getter* methods the same name as the instance variable they are exposing and setting:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def name                  # This was renamed from "get_name"
    @name
  end

  def name=(n)              # This was renamed from "set_name="
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```

Since defining these simple *getter* and *setter* methods takes up a lot of space and would take a lot of time if doing so over and over again, Ruby has a built-in way to automatically create these methods for us using the **attr_accessor** method:

```ruby
class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```

The `attr_accessor` method takes a symbol as an argument which it uses to create the method name for the `getter` and `setter` methods. If for some reason you only want the `getter` method, you could use `attr_reader`. Or if you only wanted the `setter` method, you could use `attr_writer`. You can also pass in multiple symbols to the attr_* methods like so:

```ruby
attr_accessor :name, :height, :weight
```

#### Accessor Methods in Action

We can use the instance methods we have created inside the class as well. So previously we defined the `speak` method so that it referenced the `@name` instance variable like so:

```ruby
def speak
  "#{@name} says arf!"
end
```

But now instead of referencing the instance variable directly, we want to use the `name` getter method:

```ruby
def speak
  "#{name} says arf!"
end
```

Why do this? Technically, we could just reference the instance variable, but it's generally a good idea to call the *getter* method instead. For example, suppose we are keeping track of social security numbers and we don't ever want to expose the raw data but only show the last 4 digits with the rest masked by x's, if we were to reference the `@ssn` instance variable directly, we'd need to sprinkle our entire class with code like this:

```ruby
# converts '123-45-6789' to 'xxx-xx-6789'
'xxx-xx-' + @ssn.split('-').last
```

But if we do that in the getter method instead, we only need to do it once in one place:

```ruby
def ssn
  # converts '123-45-6789' to 'xxx-xx-6789'
  'xxx-xx-' + @ssn.split('-').last
end
```

We want to do the same with our *setter* method. Wherever we are changing the instance variable directly in our class, we should instead use the setter method. But there's a gotcha, which is coming up.

Suppose we want to create a method in our `GoodDog` class that changes the name, height, and weight info for a given `GoodDog` instance (and have a method that displays the info):

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end
```

And we can use the `change_info` method like this:

```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
```

But the currently the `change_info` method is referencing the instance variables directly and we want to use the setter methods instead so we change the code like so:

```ruby
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end
```

However when we use it we notice that it does not change sparky's info:

```ruby
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.
```

Why is this?

#### Calling Methods with self

The reason it didn't work is because Ruby though we were initializing local variables. So instead of calling `name=`, `height=`, and `weight=` we actually created three new local variables called `name`, `height`, and `weight`. Not what we wanted. To disambiguate from creating a local variable, we need to use `self.name=` to let Ruby know we're calling a method. So it should look like this:

```ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```

We could adopt this syntax for the getter methods as well, though it is not required.

## Classes and Objects - Part II

### Class Methods

Class methods are methods we can call directly on the class itself without having to instantiate any objects. When defining a class method, we prepend the method name with the reserved word `self.` like so:

```ruby
# ... rest of code omitted for brevity

def self.what_am_i
  "I'm a GoodDog class!"
end
```

We can call it like so:

```ruby
GoodDog.what_am_i       # => I'm a GoodDog class!
```

### Class Variables

Class variables use two `@` symbols. Let's create a class variable and a class method to view that variable:

```ruby
class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs     # => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs     # => 2
```

This code shows that we can access class variables from with an instance method (`initialize` in this case).

### Constants

Here's an example of a use of a constant in a class definition:

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age             # => 28
```

### The to_s Method

The `to_s` instance method is included in every class in Ruby. By default the `to_s` method returns the name of the object class and an encoding of the object id. The `puts` method automatically calls the `to_s` method:

```ruby
puts sparky      # => #<GoodDog:0x007fe542323320>
```

The `puts` method calls `to_s` for any argument that is not an array. For an array, it writes on separate lines the result of calling `to_s` on each element of the array.

We could override the built-in `to_s` method by writing in our own `to_s` method if we wanted, like so:

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

puts sparky      # => This dog's name is Sparky and is 28 in dog years.
```

The method `p` is very similar to `puts` except that it doesn't call `to_s`, it calls another built-in Ruby instance method called `inspect`. The `inspect` method is very helpful for debugging, so we wouldn't want to override it.

```ruby
p sparky         # => #<GoodDog:0x007fe54229b358 @name="Sparky", @age=28>
```

This is equivalent to calling `puts sparky.inspect`.

The `to_s` method is also automatically called in string interpolation. We've seen this before when using integers or arrays in string interpolation.

### More About self

So far we've seen two clear use cases for `self`:

1. Use `self` when calling setter methods from within the class. It is necessary to disambiguate between initializing a local variable and calling a setter method.

2. Use `self` for class method definitions.

This is what we have so far in our GoodDog class:

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end
```

Let's add one more instance method to help us understand `self`:

```ruby
class GoodDog
  # ... rest of code omitted for brevity

  def what_is_self
    self
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
# => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```

From this we see that from within the class, when an instance method uses `self`, it references the *calling object* (in this case the `sparky` object). Therefore, from within the `change_info` method, calling `self.name=` acts the same as calling `sparky.name=` from *outside* the class (you can't call `sparky.name=` inside the class since it isn't in scope). 

The other place we use `self` is when we're defining class methods, like so:

```ruby
class MyAwesomeClass
  def self.this_is_a_class_method
  end
end
```

Prepending `self` to a method definition defines it as a **class method**. Earlier we defined a class method called `self.total_number_of_dogs` which returned the value of the class variable `@@number_of_dogs`.

Remember that using `self` inside a class, but outside an instance method refers to the class itself. Therefore, a method definition prefixed with `self` is the same as defining the method on the class, meaning `def self.total_number_of_dogs` is equivalent to `def GoodDog.total_number_of_dogs`. Hence why it is a class method: it's actually being defined on the class.

To summarize:

1. `self` inside of an instance method references the instance (object) that called the method (calling object)
2. `self` outside of an instance method references the class and can be used to define class methods

## Inheritance

Inheritance is when a class inherits behavior from another class. The class inheriting the behavior is the subclass and the class it inherits from is called the superclass.

### Class Inheritance

Continuing with our `GoodDog` example class, we will extract the `speak` method and place it in a superclass `Animal` and use inheritance to make it available to `GoodDog` and `Cat` classes:

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak           # => Hello!
puts paws.speak             # => Hello!
```

As we can see the `<` symbol signifies that the `GoodDog` and `Cat` classes are inheriting from the `Animal` class. This means all methods in the `Animal` class are available to these classes.

If we add the original `speak` method we created before back into the `GoodDog` class:

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak           # => Sparky says arf!
puts paws.speak             # => Hello!
```

By having a `speak` method in the `GoodDog` class we are overriding the `speak` method in the `Animal` superclass.

### super

Ruby has a built-in method `super` that lets us call methods earlier in the method lookup path. If you call `super` from within a method, it will search the method lookup path for a method with the same name and invoke it. For example:

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak            # => "Hello! from GoodDog class"
```

A common way that `super` is used is with `initialize`:

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")          # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">
```

From this we see that `super` automatically forwards the arguments that were passed to the method from which `super` is called (`initialize` method in the `GoodDog` class in this case). This is why `@name` gets set to 'brown'.  So we can fix this by adding arguments:

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(name, color)
    super(name)
    @color = color
  end
end

bruno = GoodDog.new("Bruno", "brown")        # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="Bruno">
```

One last twist: if you call `super()` exactly as shown - with parentheses - it calls the method in the superclass with no arguments. If you have a method in your superclass that takes no arguments, this is the safest and sometimes the only way to call it:

```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new("black")        # => #<Bear:0x007fb40b1e6718 @color="black">
```

If you didn't include the parentheses here you would get an `ArgumentError`.

### Mixing in Modules

Sometimes behaviors/characteristics don't make sense to distribute in a hierarchical manner and when that is the case it makes sense to use modules:

```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable         # mixing in Swimmable module
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable         # mixing in Swimmable module
end
```

### Inheritance vs Modules

**Interface inheritance** is where mixin modules come into play. The class doesn't inherit from another type but instead inherits the interface provided by the mixin module.  Here are some things to consider when deciding between **class inheritance** and **interface inheritance**:

* You can only subsclass from one class, but you can mix in as many modules as you want
* If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally the better choice.
* You can't instantiate modules (i.e. no object can be created from a module). Modules are only used for namespacing and grouping common methods together.

### Method Lookup Path

When we call a method Ruby will first look in the class of the object for the method. If it is not there, it will look through any modules that are mixed in with that class. If there are multiple modules mixed in, it actually looks at the **last** module first, for example:

```ruby
class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
```

This outputs:

```
---GoodDog method lookup---
GoodDog
Climbable
Swimmable
Animal
Walkable
Object
Kernel
BasicObject
```

We see that `Climbable` is included last in the `GoodDog` class, but is looked up first after looking at the GoodDog class in the method lookup path. If the method called is still not found it will look in the object's superclass, then the superclass's module mixins, and so on and so forth.

### More Modules

Another use case for modules is **namespacing**. Namespacing means organizing similar classes under a module. In other words we'll use modules to group related classes. This is helpful in two ways:

1. It becomes easy for us to recognize related classesin our code
2. It reduces the likelihood of our classes colliding withother similarly named classes in our codebase

```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end
```

We call classes in a module by appending the class name to the module name with two colons (`::`).

```ruby
buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')           # => "Arf!"
kitty.say_name('kitty')       # => "kitty"
```

The second use case for modules we'll look at is using modules as a **container** for methods. This is useful for methods that seem out of place within your code. For example:

```ruby
module Mammal
  ...

  def self.some_out_of_place_method(num)
    num ** 2
  end
end
```

We can call them directly from the module:

```ruby
value = Mammal.some_out_of_place_method(4)
# or
value = Mammal::some_out_of_place_method(4)
```

The first way is preferred.

### Private, Protected, and Public

So far we've only dealt with **public methods**. A public method is a method that is available ot anyone who knows either the class name or the object's name.  These methods are readily available for the rest of the program to use and comprise the class's *interface*.

Sometimes you have methods that are doing work in the class, but don't need to be available to the rest of the program. These methods can be defined as **private**. To define a method as private, we simply use the `private` method call in our program and anything below it is private (unless another method, like `protected` is called after it to negate it):

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.human_years
# => NoMethodError: private method `human_years' called for #<GoodDog:0x007f8f431441f8 @name="Sparky", @age=4>
```

What good is having private methods? Well, a `private` method can still be called by other methods in the class. For example, this would be allowed:

```ruby
# assume the method definition below is above the "private" keyword

def public_disclosure
  "#{self.name} in human years is #{human_years}"
end
```

Note that we don't use `self.human_years` because `human_years` is private.  Private methods are not accessible outside of the class definition at all.

Public and private methods are most common but sometimes we want an in-between approach. For this we use the `protected` keyword to create **protected** methods which follow these two rules:

1. from inside the class, `protected` methods are accessible just like `public` methods
2. from outside the class, `protected` methods act just like `private` methods

```ruby
class Animal
  def a_public_method
    "Will this work?" + self.a_protected.method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method        # => Will this work? Yes, I'm protected!
fido.a_protected_method     # => NoMethodError: protected method `a_protected_method' called for #<Animal:0x007fb174157110>
```

### Accidental Method Overriding

Remember that every class you create inherently subclasses from the `Object` class and therefore every method available in `Object` is available in all classes.  If you were to override a method originally defined in the `Object` class, this can have far-reaching effects in your code. It is good practice to familiarize yourself with `Object`'s methods so as not to inadvertently override them.
