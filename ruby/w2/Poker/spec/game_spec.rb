require 'rspec'
require 'game'


describe Game do
  subject(:game) { Game.new }
  let(:deck) { game.deck}
  let(:players) { game.players }
  let(:player1) { players[0] }
  let(:player2) { players[1] }
  let(:player3) { players[2] }


  describe "#intialization" do
    it "should initialize 3 example users" do
      expect(players.size).to eq(3)
    end

    it "should initialize a deck of 52 cards" do
      expect(deck.count).to eq(52)
    end
  end

  describe "#play" do
    before(:each) do
      game.deal
    end
    describe "#deal" do
      it "should give each player 5 cards" do
        game.players.each do |player|
          expect(player1.hand.cards.size).to eq(5)
        end
      end
    end

    describe "#swap_cards" do
      it "should replace the cards at the given indices" do

      end
    end

    describe "#get_action" do
      it "should get current_player's action" do
        expect(player1).to receive(:return_cards).with(deck)
      end
    end

    describe "#get_bet" do
      let(:current_player) {player1}
      it "should process first player's bet" do
        expect(game.make_current_bet).to eq()
      end
    end
  end

end
