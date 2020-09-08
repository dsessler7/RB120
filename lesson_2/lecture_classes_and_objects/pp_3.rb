class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    names = name.split
    @first_name = names[0]
    @last_name = names.size > 1 ? names[-1] : ''
  end

  def name=(name)
    names = name.split
    self.first_name = names[0]
    self.last_name = names[-1] if names.size > 1
  end

  def name
    (first_name + ' ' + last_name).strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
