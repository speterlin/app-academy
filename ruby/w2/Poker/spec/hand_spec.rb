require 'hand'
require 'deck'


describe Hand do
  let(:deck) { Deck.new }
  let(:cards) { deck.take(5) }
  subject(:hand) { Hand.new(cards) }


  it "should contain 5 cards" do
    expect(hand.cards.size).to eq(5)
    expect(hand.cards.all? { |card| card.is_a?(Card) })
  end

  describe "#swap_cards" do
    it "should change first and second card" do
      first_cards = hand.cards[0..1]
      expect(deck).to receive(:return).with(first_cards)
      hand.swap_cards(deck,[0,1])
      expect(hand.cards[0..1]).to_not eq(first_cards)
    end
  end


  describe "#points" do
    let(:suits) { [:diamonds, :clubs, :hearts, :spades ] }
    let(:values) { (1..13).to_a }
    let(:cards_flush) do
      [].tap do |array|
        5.times do
          card = Card.new(suits[0], values.sample)
          array << card
        end
      end
    end
    let(:hand_flush) { Hand.new(cards_flush)}
    let(:cards_straight) do
      [].tap do |array|
        5.times do |idx|
          card = Card.new(suits.sample, values[idx])
          array << card
        end
      end
    end
    let(:hand_straight) { Hand.new(cards_straight) }
    let(:cards_royal_flush) do
      [].tap do |array|
        5.times do |idx|
          value = 0
          if idx < 4
            value = 10 + idx
          else
            value = 1
          end
          card = Card.new(suits[1], value)
          array << card
        end
      end
    end
    let(:hand_royal_flush) { Hand.new(cards_royal_flush) }
    let(:cards_four_kind) do
      [].tap do |array|
        5.times do |idx|
          if idx < 4
            value = values.first
          else
            value = values[1]
          end
          card = Card.new(suits.sample, value)
          array << card
        end
      end
    end
    let(:hand_four_kind) { Hand.new(cards_four_kind) }
    let(:cards_straight_flush) do
      [].tap do |array|
        5.times do |idx|
          card = Card.new(suits[1], idx)
          array << card
        end
      end
    end
    let(:hand_straight_flush) { Hand.new(cards_straight_flush) }
    let(:cards_three_kind) do
      [].tap do |array|
        5.times do |idx|
          if idx < 3
            value = values.first
          else
            value = idx
          end
          card = Card.new(suits.sample, value)
          array << card
        end
      end
    end
    let(:hand_three_kind) { Hand.new(cards_three_kind) }
    let(:cards_full_house) do
      [].tap do |array|
        5.times do |idx|
          if idx < 3
            value = values.first
          else
            value = values[1]
          end
          card = Card.new(suits.sample, value)
          array << card
        end
      end
    end
    let(:hand_full_house) { Hand.new(cards_full_house) }
    let(:cards_two_pair) do
      [].tap do |array|
        5.times do |idx|
          if idx < 2
            value = values.first
          elsif idx < 4
            value = values[1]
          else
            value = idx
          end
          card = Card.new(suits.sample, value)
          array << card
        end
      end
    end
    let(:hand_two_pair) { Hand.new(cards_two_pair) }
    let(:cards_one_pair) do
      [].tap do |array|
        5.times do |idx|
          if idx < 2
            value = values.first
          else
            value = idx
          end
          card = Card.new(suits.sample, value)
          array << card
        end
      end
    end
    let(:hand_one_pair) { Hand.new(cards_one_pair) }
    let(:cards_highest_card) do
      [].tap do |array|
        5.times do |idx|
          if idx < 4
            value = idx
            suit = suits[idx]
          else
            value = 13
            suit = suits.first
          end
          card = Card.new(suit, value)
          array << card
        end
      end
    end
    let(:hand_highest_card) { Hand.new(cards_highest_card) }

    it "returns 18 when it's a flush" do
      expect(hand_flush.points).to eq(18)
    end

    it "returns 17 when it's a straight" do
      expect(hand_straight.points).to eq(17)
    end

    it "returns 22 when it's a royal flush" do
      expect(hand_royal_flush.points).to eq(22)
    end

    it "returns 20 when it's a four of a kind" do
      expect(hand_four_kind.points).to eq(20)
    end

    it "returns 21 when it's a straight flush" do
      expect(hand_straight_flush.points).to eq(21)
    end

    it "returns 16 when it's three of a kind" do
      expect(hand_three_kind.points).to eq(16)
    end

    it "returns 19 when it's a full house" do
      expect(hand_full_house.points).to eq(19)
    end

    it "returns 15 when it's a two pair" do
      expect(hand_two_pair.points).to eq(15)
    end

    it "returns 14 when it's a one paur" do
      expect(hand_one_pair.points).to eq(14)
    end

    it "returns highest card (13) when it's nothing" do
      expect(hand_highest_card.points).to eq(13)
    end

  end
end
