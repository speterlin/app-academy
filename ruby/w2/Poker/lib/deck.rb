require_relative 'card'


class Deck

  def self.all_cards
    all_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit,value)
      end
    end

    all_cards
  end

  attr_accessor :count, :cards

  def initialize(cards = self.class.all_cards)
    @cards = cards
  end

  def count
    @cards.size
  end

  def take(n)
    @cards.shuffle!
    @cards.shift(n)
  end

  def return(cards)
    @cards.concat(cards)
  end
end
