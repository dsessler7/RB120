class GuessingGame
  def play
    @number = rand(100)
    @remaining_guesses = 7

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

  attr_reader :number
  attr_accessor :remaining_guesses, :guess

  def obtain_guess
    loop do
      print "Enter a number between 1 and 100: "
      self.guess = gets.chomp
      break if guess =~ /\A[-+]?\d+\z/ && (1..100).cover?(guess.to_i)
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

game = GuessingGame.new
game.play
