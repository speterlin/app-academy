require './tree_node'
require 'byebug'

class KnightPathFinder
  VALID_MOVES = [[1,2],[2,1],[-1,2],[-2,1],[-1,-2],[-2,-1],[1,-2],[2,-1]]

  def self.valid_moves(position)
    valid_moves = []
    x, y = position[0], position[1]
    VALID_MOVES.each do |move|
      potential_move = [x + move[0], y + move[1]]
      valid_moves << potential_move if potential_move.all? {|num| num.between?(0,7)}
    end

    valid_moves
  end

  def initialize(starting_position)
    raise "Invalid position" unless on_board?(starting_position)
    @starting_node = PolyTreeNode.new(starting_position)
    @visited_positions = [starting_position]
    build_move_tree
  end

  def build_move_tree
    queue = [@starting_node]
    until queue.empty?
      # queue.each {|e| p e.value}
      # puts
      # debugger
      check_node = queue.shift
      children_positions = new_move_positions(check_node.value)
      children_positions.each do |child_position|
        child_node = PolyTreeNode.new(child_position)
        child_node.parent = check_node
        queue += [child_node]
      end
    end
  end

  def find_path(end_position)
    end_node = @starting_node.bfs(end_position)
    raise "No Path Exists" unless end_node
    end_node.trace_path_back
  end

  def new_move_positions(position)
    new_positions = self.class.valid_moves(position)
    new_positions.reject! do |valid_move|
      @visited_positions.include?(valid_move)
    end
    @visited_positions += new_positions
    new_positions
  end


  def on_board?(position)
    position.all? {|num| num.between?(0,7)}
  end

end
kpf = KnightPathFinder.new([0,0])
p kpf.find_path([7,6])
p kpf.find_path([6,2])
