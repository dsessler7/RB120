# Lesson 4: Practice Problems: Hard 1:

## Q1

```ruby
class SecretFile
  def initialize(secret_data, log)
    @data = secret_data
    @log = log
  end

  def data
    @log.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end
```

## Q2

```ruby
module Fuel
  attr_reader :fuel_capacity, :fuel_efficiency

  def range
    fuel_capacity * fuel_efficiency
  end
end

class WheeledVehicle
  include Fuel
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Fuel
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end
```

## Q3

```ruby
class Motorboat
  include Fuel
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity, num_propellers=1, num_hulls=1)
    # ... code omitted ...
  end
end

class Catamaran < Motorboat
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity, 2, 2)
  end
end
```

## Q4

```ruby
  include Fuel
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity, num_propellers=1, num_hulls=1)
    # ... code omitted ...
  end

  def range
    super + 10
  end
end
```
