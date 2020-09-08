class GuessingGame
  def initialize(low=1, high=100)
    @range = (low..high)
    @remaining_guesses = Math.log2(@range.size).to_i + 1
  end

  def play
    @number = rand(@range)

    loop do
      puts "You have #{remaining_guesses} guesses remaining."
      obtain_guess
      self.remaining_guesses -= 1
      check_guess
      break if correct? || remaining_guesses == 0
    end

    puts correct? ? "You won!" : "You have no more guesses. You lost!"
  end

  private

  attr_reader :number, :range
  attr_accessor :remaining_guesses, :guess

  def obtain_guess
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      self.guess = gets.chomp
      break if guess =~ /\A[-+]?\d+\z/ && (range).cover?(guess.to_i)
      print "Invalid guess. "
    end
    self.guess = guess.to_i
  end

  def check_guess
    case guess <=> number
    when 1 then puts "Your guess is too high."
    when 0 then puts "That's the number!"
    when -1 then puts "Your guess is too low."
    end
    puts ''
  end

  def correct?
    guess == number
  end
end

game = GuessingGame.new(501, 1500)
game.play
