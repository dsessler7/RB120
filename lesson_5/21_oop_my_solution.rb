class Participant
  attr_accessor :hand

  def initialize
    @hand = []
  end

  def hit(deck)
    hand << deck.deal_card
  end

  def busted?
    total > 21
  end

  def total
    non_aces, aces = hand.partition { |card| card.value != :Ace }
    total = non_aces.inject(0) do |collector, card|
      card.value.class == Integer ? collector + card.value : collector + 10
    end
    total += aces.size
    total += 10 if total <= 11 && !aces.empty?
    total
  end
end

class Deck
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :Jack, :Queen, :King, :Ace]
  SUITS = [:Hearts, :Diamonds, :Spades, :Clubs]

  def initialize
    @cards = []
    SUITS.each { |suit| VALUES.each { |val| @cards << Card.new(val, suit) } }
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "The #{value} of #{suit}"
  end
end

class Game
  attr_reader :human, :dealer, :deck

  def initialize
    system 'clear'
    @human = Participant.new
    @dealer = Participant.new
  end

  def start
    display_welcome_message
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn unless human.busted?
      show_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to 21!"
    puts ''
  end

  def deal_cards
    @deck = Deck.new
    human.hand << deck.deal_card << deck.deal_card
    dealer.hand << deck.deal_card << deck.deal_card
  end

  def show_initial_cards
    show_some_cards
  end

  def player_turn
    loop do
      hit? ? human.hit(deck) : break
      clear_screen_and_show_some_cards
      break if human.busted?
    end
  end

  def dealer_turn
    clear_screen_and_show_all_cards
    loop do
      dealer.total < 17 ? dealer.hit(deck) : break
      clear_screen_and_show_all_cards
      break if dealer.busted?
    end
  end

  def show_result
    human_total = human.total
    dealer_total = dealer.total
    case
    when human.busted? then puts "You busted!"
    when dealer.busted? then puts "You won! The dealer busted!"
    when human_total > dealer_total then puts "You won!"
    when dealer_total > human_total then puts "You lost!"
    else puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def reset
    system 'clear'
    human.hand = []
    dealer.hand = []
  end

  def display_goodbye_message
    puts "Goodbye! Thanks for playing 21!!"
  end

  def hit?
    choice = nil
    loop do
      puts "Would you like to hit or stay? (Type 'h' for hit, 's' for stay.)"
      choice = gets.chomp
      break if %w(h s).include?(choice)
      puts "Invalid input. Must type 'h' or 's'."
    end
    choice == 'h'
  end

  def show_some_cards
    puts "You have:"
    human.hand.each { |card| puts card }
    puts "Your total is #{human.total}."
    puts ''
    puts "The dealer has:"
    puts dealer.hand.first
    puts "The ??? of ???"
    puts ''
  end

  def clear_screen_and_show_some_cards
    system 'clear'
    show_some_cards
  end

  def show_all_cards
    puts "You have:"
    human.hand.each { |card| puts card }
    puts "Your total is #{human.total}."
    puts ''
    puts "The dealer has:"
    dealer.hand.each { |card| puts card }
    puts "The dealer's total is #{dealer.total}."
    puts ''
  end

  def clear_screen_and_show_all_cards
    system 'clear'
    show_all_cards
  end
end

Game.new.start
