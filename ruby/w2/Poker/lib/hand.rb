class Hand
  POKERHANDS = []
  HIGH_ACE_STRAIGHT = [13, 12, 11, 10, 1]

  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  def self.winning_hand(players)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    if royal_flush?
      Card::POKER_VALUE[:royal_flush]
    elsif straight_flush?
      Card::POKER_VALUE[:straight_flush]
    elsif four_kind?
      Card::POKER_VALUE[:four_kind]
    elsif full_house?
      Card::POKER_VALUE[:full_house]
    elsif straight?
      Card::POKER_VALUE[:straight]
    elsif flush?
      Card::POKER_VALUE[:flush]
    elsif three_kind?
      Card::POKER_VALUE[:three_kind]
    else
      highest_card
    end
  end

  def discard(n)

  end

  def swap_cards(deck,indices)
    return_cards = []
    indices.each do |idx|
      return_cards << @cards[idx]
      @cards[idx] = deck.take(1)
    end

    deck.return(return_cards)
  end

  def strongest_hand?(other_hands)
    other_hands.all? do |other_hand|
      self.points > other_hand.points #doesn't handle ties
    end
  end


  private


  def highest_card
    (@cards.map {|card| card.value}).max
  end

  def three_kind?
    reverse_values.any? {|value| reverse_values.count(value) == 3} && !four_kind?
  end

  def full_house?
    three_kind? && one_pair?
  end

  def one_pair?
    reverse_values.any? {|value| reverse_values.count(value) == 2} &&
    (reverse_values.uniq.length == 4 || reverse_values.uniq.length == 2)
  end

  def two_pair?
    reverse_values.any? {|value| reverse_values.count(value) == 2} &&
    reverse_values.uniq.length == 3 && !three_kind?
  end

  def royal_flush?
    values = reverse_values
    straight? && flush? && values.include?(10) && values.include?(1) &&
    values == HIGH_ACE_STRAIGHT
  end

  def straight?
    values = reverse_values
    return true if (0...(values.length-1)).all? do |idx|
      values[idx] - values[idx+1] == 1
    end

    HIGH_ACE_STRAIGHT == values
  end

  def straight_flush?
    values = reverse_values
    straight? && flush? && (HIGH_ACE_STRAIGHT != values)
  end

  def inspect
    {:cards => @cards}.inspect
  end

  def flush?
    @cards.all? { |card| card.suit == @cards.first.suit }
  end

  def reverse_values
    sorted = @cards.sort { |card1, card2| card2.value <=> card1.value }
    sorted.map(&:value)
  end



  def four_kind?
    reverse_values.any? {|value| reverse_values.count(value) == 4}
  end
end
