class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
end

class Rock
  def >(other_move)
    other_move.class == Lizard || other_move.class == Scissors
  end

  def <(other_move)
    other_move.class == Paper || other_move.class == Spock
  end

  def to_s
    'rock'
  end
end

class Paper
  def >(other_move)
    other_move.class == Rock || other_move.class == Spock
  end

  def <(other_move)
    other_move.class == Scissors || other_move.class == Lizard
  end

  def to_s
    'paper'
  end
end

class Scissors
  def >(other_move)
    other_move.class == Paper || other_move.class == Lizard
  end

  def <(other_move)
    other_move.class == Rock || other_move.class == Spock
  end

  def to_s
    'scissors'
  end
end

class Lizard
  def >(other_move)
    other_move.class == Paper || other_move.class == Spock
  end

  def <(other_move)
    other_move.class == Scissors || other_move.class == Rock
  end

  def to_s
    'lizard'
  end
end

class Spock
  def >(other_move)
    other_move.class == Scissors || other_move.class == Rock
  end

  def <(other_move)
    other_move.class == Paper || other_move.class == Lizard
  end

  def to_s
    'spock'
  end
end

class Player
  attr_accessor :move, :name, :score, :choices

  def initialize
    set_name
    @score = 0
    @choices = []
  end

  def choose(choice)
    case choice
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
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
    self.move = super(choice)
  end
end

class Computer < Player
  PERSONALITY_MOVES = {
    'R2D2' => ['rock'],
    'Hal' => ['scissors', 'scissors', 'scissors', 'spock', 'spock', 'lizard',
              'lizard', 'rock'],
    'Chappie' => ['spock', 'spock', 'spock', 'lizard', 'rock', 'paper',
                  'scissors'],
    'Sonny' => ['spock', 'scissors'],
    'Number 5' => ['rock', 'paper', 'scissors', 'lizard', 'spock']
  }

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = case (Computer::PERSONALITY_MOVES[name].sample)
                when 'rock' then Rock.new
                when 'paper' then Paper.new
                when 'scissors' then Scissors.new
                when 'lizard' then Lizard.new
                when 'spock' then Spock.new
                end
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

  def archive_choices
    human.choices << human.move.to_s
    computer.choices << computer.move.to_s
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def tally_score
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
  end

  def display_score
    puts "The score is #{human.score}-#{computer.score}."
  end

  def winner?
    human.score >= 10 || computer.score >= 10
  end

  def display_history
    answer = nil
    loop do
      puts "Would you like to display your move history? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    return unless answer == 'y'
    human.choices.each_with_index do |mv, i|
      puts "You chose #{mv} and #{computer.name} chose #{computer.choices[i]}."
    end
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
      archive_choices
      display_moves
      display_winner
      tally_score
      display_history
      display_score unless winner?
      break if winner? || !play_again?
    end
    display_game_winner if winner?
    display_goodbye_message
  end
end

RPSGame.new.play
