# require 'rspec'
require 'deck'
require 'byebug'

describe Deck do
  subject(:deck) { Deck.new }
  let(:all_cards) { Deck.all_cards }

  it "should contain 52 cards at first" do
    expect(deck.cards.size).to eq(52)
    expect(deck.cards.all? { |card| card.is_a?(Card) }).to eq(true)
  end

  it "returns all cards without duplicates" do
    deduped_cards = all_cards
      .map { |card| [card.suit, card.value] }
      .uniq
      .count
    expect(deduped_cards).to eq(52)
  end

  describe "#take" do
    it "should take a random card, remove card from deck" do
      expect(deck.cards).to receive(:shift)
      card = deck.take(1)
      expect(deck.cards.include?(card)).to be(false)
      expect(deck.count == 51)
    end
  end

  describe "#return" do
    let(:cards) do
      cards = [
        Card.new(:spades, :king),
        Card.new(:spades, :queen),
        Card.new(:spades, :jack)
      ]
    end
    before(:each) do
      deck.take(3)
      deck.return(cards)
    end

    it "should take an array of cards, and place them at the bottom of deck" do
      expect(deck.cards[49..-1]).to eq(cards)
    end
  end
end
