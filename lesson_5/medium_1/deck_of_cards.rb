class Card
  include Comparable
  attr_reader :rank, :suit, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = case rank
             when 'Ace' then 14
             when 'King' then 13
             when 'Queen' then 12
             when 'Jack' then 11
             else rank
             end
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  attr_reader :cards

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    create_deck
    shuffle_deck
  end

  def create_deck
    @cards = []
    SUITS.each { |suit| RANKS.each { |rank| @cards << Card.new(rank, suit) } }
  end

  def shuffle_deck
    @cards.shuffle!.shuffle!.shuffle!
  end

  def draw
    card = @cards.pop
    if @cards.empty?
      create_deck
      shuffle_deck
    end
    card
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
