class Player



  attr_accessor :name, :hand, :bankroll, :folded

  def initialize(name,bankroll)
    @name = name
    @bankroll = bankroll
    @folded = false
  end

  def get_discard
    puts "Enter indices of cards you wish to replace"
    indices = gets.chomp.split(",").map {|coord_s| Integer(coord_s)}
    raise ArgumentError unless indices.all? {|idx| idx.between?(0,4) }
    raise ArgumentError if indices.length > 3
    indices
  end

  def get_action(highest_bet)
    if highest_bet == 0
      puts "Enter fold, bet, check"
    else
      puts "Enter fold, see, raise, check"
    end
    input = gets.chomp
    raise ArgumentError if (input =~ /^fold$|^bet$|^see$|^raise$|^check$/).nil?
    input
  end

  def take_bet(amt)
    raise ArgumentError, "Exceeded bankroll" if amt > @bankroll
    @bankroll -= amt
  end

  def get_bet(already_bet = 0)
    raise ArgumentError, "no money to bet" if @bankroll == 0
    puts "Enter amount you wish to bet"
    amt = Integer(gets.chomp)
    amt  #return only size of new bet (not total bet)
  end

  def see(amt)
    raise ArgumentError, "amount exceeds bankroll" if amt > @bankroll
  end

  def folded?
    @folded
  end


  def pay_winnings(amt)
    @bankroll += amt
  end

  # private
  def replaces(indices)

  end
end
