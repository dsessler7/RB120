# Classes and Objects Part I Exercises

## 1.

Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

```ruby
class MyCar
  attr_accessor :year, :color, :model, :current_speed

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
end
```

## 2 and 3

```ruby
class MyCar
  attr_accessor :color, :current_speed
  attr_reader :year

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
end
```
