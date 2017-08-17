require_relative 'board'
require_relative 'piece'
require 'byebug'
require 'colorize'
require 'io/console'

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @players = {
      :red => HumanPlayer.new(:red),
      :black => HumanPlayer.new(:black)
    }
    @current_player = :red
  end

  def play
    until @board.over?
      print_board
      @players[@current_player].play_turn(@board)
      switch_player
      system "clear"
    end
  end

  def print_board
    puts board.render
  end

  def switch_player
    @current_player = @current_player == :red ? :black : :red
  end

end

class HumanPlayer
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def play_turn(board)
    puts "Current player: #{color}"
    begin
    start_pos, *end_seq = get_seq("Enter sequence: ")
    valid_start_pos?(start_pos, board)
    start_piece = board[start_pos]
    start_piece.perform_moves(end_seq)
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end
  # rescue RuntimeError => e
  #   retry
  # end
    # next_pos = get_more("Enter in next coordinate if you want to make another move, otherwise enter n")


  end

  private

  def valid_start_pos?(start_pos, board)
    raise "Invalid start position" unless board[start_pos] && board[start_pos].color == self.color
    true
  end

  def get_pos(prompt)
    puts prompt
    gets.chomp.split(",").map(&:to_i)
  end

  def get_seq(prompt) #returns an array
    puts prompt
    positions = []
    positions << get_pos("First position")

    next_pos = get_pos("Second position")
    until end_seq = next_pos.empty?
      positions << next_pos
      next_pos = get_pos("Next position(s)")
    end

    positions
  end

end



if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
  # board = game.board
  # piece = board[[2,0]]
  # piece.perform_moves([[3,1]])
  # piece.perform_moves([[4,1],[3,2]])
  # puts "\n"
  # puts board.render

end
