# Classes and Objects Part II: Exercises

## Question 1:

Add a class method to your MyCar class that calculates the gas mileage of any car

```ruby
class MyCar
  attr_accessor :color, :current_speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up
    self.current_speed += 1
  end

  def brake
    self.current_speed -= 1
  end

  def turn_off
    self.current_speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def self.gas_mileage(gallons_gas_burned, miles_driven)
    miles_driven/gallons_gas_burned
  end
end
```

## Question 2

Override the to_s method to create a user friendly print out of your object

```ruby
class MyCar
  attr_accessor :color, :current_speed
  attr_reader :year, :model

  # ... code omitted for brevity

  def to_s
    puts "This car is a #{color}, #{year} #{model}."
  end
end
```

## Question 3

When running the following code:

```ruby
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

We get the following error:

```ruby
test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
```

Why do we get this error and how do we fix it?

We are getting this error because the code is trying to use a setter method to set a new value for the name instance variable; however, we do not have a setter method available. We only have a getter method available since we used the `attr_reader` method to create this method. If we want both a getter and a setter method for our `@name` instance variable then we would want to change `attr_reader` to `attr_accessor` which will fix the error.

