class Pet
  attr_reader :name, :type

  def initialize(type, name)
    @type = type 
    @name = name 
  end
end

class Owner
  @@number_of_pets = 0
  attr_reader :name

  def initialize(name)
    @name = name 
  end

  def adopt
    @@number_of_pets += 1
  end

  def number_of_pets
    @@number_of_pets
  end
end

class Shelter
  def initialize
    @adoptions = {}
  end

  def adopt(owner, pet)
    owner.adopt
    if @adoptions.key?(owner)
      @adoptions[owner] << pet
    else 
      @adoptions[owner] = [pet]
    end
  end

  def print_adoptions
    @adoptions.each do |owner, pets|
      puts "#{owner.name} has the following pets:"
      pets.each do |pet|
        puts "a #{pet.type} named #{pet.name}"
      end
      puts ''
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
