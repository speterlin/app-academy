require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    new_node = TicTacToeNode.new(game.board, mark)
    # debugger

    new_mark = mark == :x ? :o : :x
    new_node.children.each do |child_node|
      if child_node.losing_node?(new_mark)
        return child_node.prev_move_pos
      end
    end

    # return new_node.prev_move_pos if any_winners

    new_node.children.each do |child_node|
      unless child_node.winning_node?(new_mark)
        return child_node.prev_move_pos
      end
    end
    raise "Error! No non-losing nodes"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

# test_board = Board.new
# test_board[[0,0]] = :x
# test_board[[1,0]] = :o
# test_board[[1,1]] = :o
#
# p subject.move(blockable_win_game, :x)
