require_relative 'hand'
require_relative 'player'
require_relative 'deck'
require 'byebug'



class Game

  #Need to hash out poker hands, and fix some game play issues
  def self.players(count)
    players = []
    count.times do |num|
      players << Player.new("Example User #{num+1}", 100)
    end

    players
  end

  attr_accessor :deck, :current_player, :players, :pot, :highest_bet, :round, :current_bets, :current_raises

  def initialize(players = self.class.players(3)) #makes 3 example players unless specified
    @players = players
    @current_player = players[0]
    @pot = 0
    @highest_bet = 0
    @current_bets = Hash.new(0)
    @current_raises = Hash.new(0)
    @deck = Deck.new
    @round = 1
    @game_over = false
  end

  def deal
    @players.each do |player|
      player.hand = Hand.deal_from(@deck)
    end
  end

  def play
    deal
    until round > 2 || all_folded? || game_over?
      begin
      puts "#{@current_player.name}'s turn, player's current bet:#{@current_bets[@current_player]}, bankroll: #{@current_player.bankroll}, raises: #{@current_raises[@current_player]}"
      puts "Highest bet: #{@highest_bet}"
      puts "Current pot: #{@pot}"
      p @current_player.hand
      indices = @current_player.get_discard if @round == 2
      process_discard(@current_player,indices) if @round == 2
      p @current_player.hand if @round == 2
      action = @current_player.get_action(@highest_bet)
      process_action(@current_player,action)
    rescue ArgumentError => e
      puts "Error: #{e.message}"
      retry
    else
      switch_player
    end
    end
    winner = pay_winner
    puts "#{winner} has won!"

  end

  def switch_player
    next_player = find_next_player(@current_player)
    until active_players.include?(next_player)
      next_player = find_next_player(next_player)
      next_round?
    end
    @current_player = next_player
  end

  def next_round?
    return false if active_players.any? {|player| @current_bets[player] < @highest_bet}

    true
  end

  def next_round
    @round += 1
    @highest_bet = 0
    @current_bets = Hash.new(0)
    @current_raises = Hash.new(0)
    pay_winner if active_players.size == 1
  end

  def find_next_player(player)
    curr_idx = @players.index(player)
    next_idx = curr_idx +1
    if next_idx >= @players.length #if at the last player
      next_idx = 0
      next_round if next_round?
    end
    @players[next_idx]
  end

  def all_folded?
    @players.all? { |player| player.folded }
  end

  def active_players
    @players.select do |player|
      player.folded == false
    end
  end

  def game_over?
    @game_over
  end

  def other_hands(player)
    other_players = active_players.select {|active_player| active_player != player }
    other_players.map {|other_player| other_player.hand }
  end

  def pay_winner
    winner = ""
    active_players.each do |player|
      if (player.hand).strongest_hand?(other_hands(player))
        player.pay_winnings(@pot)
        winner = player.name
      end
    end

    game_over = true if winner != ""
    winner
  end

  def process_discard(player, indices)
    player.hand.swap_cards(deck, indices)
  end

  def process_action(player, action) #current_bets needs to be reset to 0
    case action
    when "fold"
      player.folded = true
    when "bet"
      raise ArgumentError, "highest bet already set" if @highest_bet != 0
      bet_amt = player.get_bet
      player.take_bet(bet_amt)
      @highest_bet = bet_amt
      @current_bets[player] += @highest_bet
      @pot += @highest_bet
    when "raise"
      raise ArgumentError, "highest bet not set" if @highest_bet == 0
      raise ArgumentError, "only one raise per round" if @current_raises[player] >= 1
      diff = @highest_bet - @current_bets[player]
      raise ArgumentError, "already at highest bet" if diff == 0
      # already_bet = @current_bets[player] if @current_bets[player] != 0
      raise_amt =  player.get_bet(@current_bets[player])
      raise ArgumentError, "raise can't be 0" if raise_amt == 0
      total_added = (raise_amt + @highest_bet) - @current_bets[player]
      player.take_bet(total_added)
      @highest_bet += raise_amt #need to differentiate between pot and current bet
      @current_bets[player] += total_added
      @pot += total_added
      @current_raises[player] += 1
    when "see"
      diff = @highest_bet - @current_bets[player]
      player.take_bet(diff)
      @current_bets[player] += diff
      player.see(diff)
      @pot += diff
    when "check"
      diff = @highest_bet - @current_bets[player]
      raise ArgumentError, "need to see to stay active" if diff > 0
      #else do nothing, move onto next move
    end
  end

  def make_current_bet
  end

  def play_turn
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play

end
