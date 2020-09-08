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

  def age  
    "Your #{self.model} is #{self.years_old} years old."
  end

  private

  def years_old
    Time.new.year - self.year
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
puts car.age
truck = MyTruck.new(2020, "black", "Tundra")
truck.tow(car)

drew = Student.new("Drew", 97)
dave = Student.new("David", 95)
puts "Well done!" if drew.better_grade_than?(dave)
