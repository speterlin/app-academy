class Card

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :ace   => 1,
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13
  }

  POKER_VALUE = {
    :royal_flush => 22,
    :straight_flush => 21,
    :four_kind  => 20,
    :full_house  => 19,
    :flush   => 18,
    :straight => 17,
    :three_kind => 16,
    :two_pair  => 15,
    :one_pair   => 14
  }

  attr_accessor  :suit, :value

  def initialize(suit,value)
    @suit = suit
    @value = value
  end

  def self.suits
    SUIT_STRINGS.keys
  end

  def inspect
    {:suit => @suit, :value => @value}.inspect
  end

  def self.values
    VALUE_STRINGS.values
  end

end
