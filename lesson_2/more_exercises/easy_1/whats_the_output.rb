class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name    # 42
puts fluffy         # My name is 42.
puts fluffy.name    # 42
puts name           # 43

# The to_s method in initialize converts the number
# to a string and therefore is a fresh object that is
# separate from `name`