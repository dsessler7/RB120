class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    if rock?
      other_move.scissors? || other_move.lizard?
    elsif paper?
      other_move.rock? || other_move.spock?
    elsif scissors?
      other_move.paper? || other_move.lizard?
    elsif lizard?
      other_move.paper? || other_move.spock?
    elsif spock? 
      other_move.rock? || other_move.scissors?
    end
  end

  def <(other_move)
    if rock?
      other_move.paper? || other_move.spock?
    elsif paper?
      other_move.scissors? || other_move.lizard?
    elsif scissors?
      other_move.rock? || other_move.spock?
    elsif lizard?
      other_move.rock? || other_move.scissors?
    elsif spock?
      other_move.paper? || other_move.lizard?
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "The score is #{human.score}-#{computer.score}."
  end

  def winner?
    human.score >= 10 || computer.score >= 10
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def display_game_winner
    puts "The game is over!"
    if human.score >= 10
      puts "#{human.name} won #{human.score}-#{computer.score}!"
    else 
      puts "#{computer.name} won #{human.score}-#{computer.score}."
    end
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_score unless winner?
      break if winner? || !play_again?
    end
    display_game_winner if winner?
    display_goodbye_message
  end
end

RPSGame.new.play
