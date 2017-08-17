require_relative 'tic_tac_toe'
require 'byebug'

class Array
  def deep_dup
    self.map {|el| el.is_a?(Array) ? el.deep_dup : el}
  end
end

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # current_player_mark = evaluator
    winner_mark = @board.winner
    return true if winner_mark != evaluator && winner_mark

    other_mark = @next_mover_mark == :x ? :o : :x
    if evaluator == @next_mover_mark
      return true if children.all? do |child|
        child.losing_node?(@next_mover_mark)
      end
    else
      return true if children.any? do |child|
        child.losing_node?(evaluator)
      end
    end

    false
  end

  def winning_node?(evaluator)
    winner_mark = @board.winner
    #winning mark is x, current mark is o
    # debugger
    return true if winner_mark == evaluator

    # current_player_mark = @next_mover_mark
    #if it's current player mark
    if evaluator != @next_mover_mark
      return true if children.any? do |child|
        child.winning_node?(evaluator)
      end
    else #evaluator != @next_mover_mark
      return true if children.all? do |child|
        child.winning_node?(@next_mover_mark)
      end
    end

    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    @board.rows.each_with_index do |row, i|
      row.each_with_index do |position, j|
        if position.nil?
          # debugger
          dup_board = @board.dup #.rows.deep_dup
          dup_board.rows[i][j] = @next_mover_mark
          next_mark = @next_mover_mark == :x ? :o : :x
          # @prev_move_pos = [i, j]
          # @next_mover_mark = next_mark
          children << TicTacToeNode.new(dup_board, next_mark, [i,j])
        end
      end
    end

    children
  end
end

# brd = TicTacToeNode.new(Board.new, :x, [0,2])
# p = brd.children

node = TicTacToeNode.new(Board.new, :x)
node.board[[0,0]] = :x
node.board[[0,1]] = :x
node.board[[0,2]] = :x

node.winning_node?(:o)
