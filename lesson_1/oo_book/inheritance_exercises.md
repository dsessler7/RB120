# Inheritance Exercises

## Question 1

Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.

```ruby
class Vehicle
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

class MyCar < Vehicle
  CAN_TOW = false
end

class MyTruck < Vehicle
  CAN_TOW = true
end
```

## Question 2

Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.

```ruby
class Vehicle
  # ... code omitted for brevity

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.print_number_of_vehicles
    p @@number_of_vehicles
  end
end
```

## Question 3

Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

```ruby
module Towing
  def tow(car)
    puts "This truck is towing the #{car.model} to the shop."
  end
end

class MyTruck < Vehicle
  include Towing
  CAN_TOW = true
end
```

## Question 4

Print to the screen your method lookup for the classes that you have created.

```ruby
puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors
```

## Question 5

```ruby
module Towing
  def tow(car)
    puts "This truck is towing the #{car.model} to the shop."
  end
end

class Vehicle
  attr_accessor :color, :current_speed
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles +=1
  end

  def self.print_number_of_vehicles
    p @@number_of_vehicles
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

class MyCar < Vehicle
  CAN_TOW = false

  def to_s
    "This car is a #{self.color}, #{self.year} #{self.model}."
  end
end

class MyTruck < Vehicle
  include Towing
  CAN_TOW = true
end

# puts Vehicle.ancestors
# puts MyCar.ancestors
# puts MyTruck.ancestors

car = MyCar.new(2009, "silver", "Elantra")
puts car.year
puts car.color
puts car.model
car.speed_up
car.speed_up
car.speed_up
puts car.current_speed
car.brake
puts car.current_speed
Vehicle.print_number_of_vehicles
car.spray_paint("Green")
puts car
```

## Question 6

```ruby
class Vehicle
  # ... code omitted for brevity

  def age  
    "Your #{self.model} is #{self.years_old} years old."
  end

  private

  def years_old
    Time.new.year - self.year
  end
end
```

## Question 7

```ruby
class Student
  attr_reader :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(peer)
    self.grade > peer.grade
  end

  protected

  def grade
    @grade
  end
end

drew = Student.new("Drew", 97)
dave = Student.new("David", 95)
puts "Well done!" if drew.better_grade_than?(dave)
```

## Question 8

The problem is that the `hi` method is a private method. To fix this problem, the `hi` method should be made public or a public method should be created that can call the `hi` method and pass along its return value.
