class MinilangError < StandardError; end
class EmptyStackError < MinilangError; end
class BadTokenError < MinilangError; end

class Minilang
  attr_reader :register
  attr_accessor :commands, :stack

  def initialize(input_string)
    @program = input_string
  end

  def eval(value=nil)
    @register = 0
    @stack = []
    @commands = format(@program, value).split
    commands.each { |command| evaluate_command(command) }
  rescue MinilangError => e
    puts e.message
  end

  def evaluate_command(command)
    if command.to_i.to_s == command
      self.register = command
    else
      case command
      when 'PUSH' then push
      when 'ADD' then add
      when 'SUB' then sub
      when 'MULT' then mult
      when 'DIV' then div
      when 'MOD' then mod
      when 'POP' then pop_one
      when 'PRINT' then print
      else raise BadTokenError, "Invalid token: #{command}"
      end
    end
  end

  def push
    stack << register
  end

  def add
    stack_val = pop_one
    self.register += stack_val
  end

  def sub
    stack_val = pop_one
    self.register -= stack_val
  end

  def mult
    stack_val = pop_one
    self.register *= stack_val
  end

  def div
    stack_val = pop_one
    self.register /= stack_val
  end

  def mod
    stack_val = pop_one
    self.register %= stack_val
  end

  def pop_one
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end

  def print
    puts register
  end

  def register=(n)
    @register = n.to_i
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

FAHRENHEIT_TO_CENTIGRADE =
  '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'
minilang = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)
minilang.eval(degrees_f: 212)
# 100
minilang.eval(degrees_f: 32)
# 0
minilang.eval(degrees_f: -40)
# -40
