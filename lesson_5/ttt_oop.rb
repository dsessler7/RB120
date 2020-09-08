class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key].marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      if line.map { |num| @squares[num].marker }.uniq.count == 1
        return @squares[line[0]].marker if @squares[line[0]].marker != ' '
      end
    end
    nil
  end

  def reset
    @squares = (1..9).each_with_object({}) do |i, hsh|
      hsh[i] = Square.new
    end
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :name, :marker
  #attr_reader :marker

  def initialize(marker)
    @marker = marker
    @score = 0
  end
end

class Human < Player
  def set_name
    input = nil
    loop do
      puts "What is your name?"
      input = gets.chomp
      break unless input.empty?
      puts "Surely you must have a name."
    end
    self.name = input
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = 'choose'

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
    @turn = FIRST_TO_MOVE
  end

  def play
    wipe_screen
    display_welcome_message
    human.set_name
    computer.set_name
    pick_markers if pick_markers?
    choose_first_player if FIRST_TO_MOVE == 'choose'
    main_game
    display_winner if game_over?
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer

  def main_game
    loop do
      display_board
      player_move
      display_result
      tally_score
      display_score unless game_over?
      break if game_over? || !play_again?
      reset
      display_play_again_message
    end
  end
  
  def pick_markers?
    input = nil
    loop do
      puts "#{human.name}, would you like to pick your marker? (y to pick, n to use defaults)"
      input = gets.chomp
      break if %w(y n).include?(input)
      puts "Please answer y or n."
    end
    input == 'y'
  end

  def pick_markers
    input = nil
    loop do
      puts "What do you want your marker to be, #{human.name}? (one character only)"
      input = gets.chomp
      break if input.size == 1
      puts "Invalid input. Please input one character."
    end
    human.marker = input
    loop do
      puts "What should #{computer.name}'s marker be? (one character only)"
      input = gets.chomp
      break if input.size == 1 && input != human.marker
      puts "Invalid input. Must be one character long."
      puts "#{computer.name} cannot have the same marker as you."
    end
    computer.marker = input
  end

  def choose_first_player
    answer = nil
    loop do
      puts "Who should go first? (player or computer)"
      answer = gets.chomp
      break if %w(player computer).include?(answer)
      puts "Sorry that's not a valid option."
    end
    answer == 'player' ? @turn = human.marker : @turn = computer.marker
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe, #{human.name}! Goodbye!"
  end

  def display_board
    puts "#{human.name} is #{human.marker}. #{computer.name} is #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    wipe_screen
    display_board
  end

  def human_moves
    puts "#{human.name}, choose a square between (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def find_winning_square
    Board::WINNING_LINES.each do |line|
      markers = line.map { |num| board[num] }
      if markers.count(computer.marker) == 2 && markers.none?(human.marker)
        return line.select { |num| board[num] == ' ' }.first
      end
    end
    nil
  end

  def find_losing_square
    Board::WINNING_LINES.each do |line|
      markers = line.map { |num| board[num] }
      if markers.count(human.marker) == 2 && markers.none?(computer.marker)
        return line.select { |num| board[num] == ' ' }.first
      end
    end
    nil
  end

  def computer_moves
    if find_winning_square
      board[find_winning_square] = computer.marker
    elsif find_losing_square
      board[find_losing_square] = computer.marker
    elsif board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then puts "#{human.name} won!"
    when computer.marker then puts "#{computer.name} won!"
    else puts "The board is full! It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def wipe_screen
    system 'clear'
  end

  def reset
    board.reset
    choose_first_player
    wipe_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if human_turn?
      human_moves
      @turn = computer.marker
    else
      computer_moves
      @turn = human.marker
    end
  end

  def human_turn?
    @turn == human.marker
  end

  def joinor(arr, delimiter=', ', conjunction='or')
    if arr.size == 1
      arr[0]
    elsif arr.size == 2
      "#{arr[0]} #{conjunction} #{arr[-1]}"
    else
      arr[0..-2].join(delimiter) + delimiter + conjunction + ' ' + arr[-1].to_s
    end
  end

  def tally_score
    case board.winning_marker
    when human.marker then human.score += 1
    when computer.marker then computer.score += 1
    end
  end

  def display_score
    human_score = human.score
    computer_score = computer.score
    if human_score > computer_score
      puts "#{human.name} is winning #{human_score}-#{computer_score}."
    elsif computer_score > human_score
      puts "#{computer.name} is winning #{human_score}-#{computer_score}."
    else
      puts "It's a tie, #{human_score}-#{computer_score}."
    end
  end

  def game_over?
    human.score >= 5 || computer.score >= 5
  end

  def display_winner
    if human.score > computer.score
      puts "#{human.name} won #{human.score}-#{computer.score}!"
    else
      puts "#{computer.name} won #{human.score}-#{computer.score}!"
    end
  end
end

# we'll kick off the game like this
game = TTTGame.new
game.play
