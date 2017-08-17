class Piece

  attr_accessor :pos, :color, :board
  attr_reader

  def initialize(pos,color,board)
    @pos = pos
    @color = color
    @board = board
    @king = false
  end

  def render
    "o".colorize(@color)
  end

  def valid_slide?(end_pos)
    # start_piece = @board[start_pos]
    # debugger
    start_piece = self
    start_pos = start_piece.pos
    end_piece = @board[end_pos]
    delta = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]

    move_diffs(start_piece.color).include?(delta) &&
    end_piece == nil
  end

  def find_middle_pos(end_pos) #only for jumps
    start_pos = self.pos
    delta_jump = [end_pos[0] - start_pos[0], end_pos[1] - start_pos[1]]
    delta = [delta_jump[0] / 2.to_f, delta_jump[1] / 2.to_f]
    [start_pos[0] + delta[0].to_i, start_pos[1] + delta[1].to_i]
  end

  def valid_jump?(end_pos)
    # start_piece = @board[start_pos]
    start_piece = self
    start_pos = start_piece.pos
    end_piece = @board[end_pos]
    middle_pos = find_middle_pos(end_pos)
    delta = [middle_pos[0] - start_pos[0], middle_pos[1] - start_pos[1]]


    move_diffs(start_piece.color).include?(delta) &&
    @board[middle_pos] &&
    @board[middle_pos].color != start_piece.color &&
    @board[end_pos] == nil
  end

  def perform_moves!(move_seq)
    if move_seq.length == 1
      if valid_slide?(move_seq[0])
        perform_slide(move_seq[0])
      elsif valid_jump?(move_seq[0])
        perform_jump(move_seq[0])
      else
        raise "Invalid move"
      end
    else
      if move_seq.all? {|pos| valid_jump?(pos) }
        move_seq.each do |pos|
          perform_jump(pos)
        end
      else
        raise "Invalid move"
      end
    end

  end

  def valid_move_seq?(move_seq)
    dup_board = @board.deep_dup
    piece_pos = self.pos
    piece = dup_board[piece_pos]
    begin
    piece.perform_moves!(move_seq)
  rescue
    return false
  end

    true
  end

  def perform_moves(move_seq)
    byebug if move_seq.include?([4,4]) || move_seq.include?([2,6])
    piece = self
    if piece.valid_move_seq?(move_seq)
      perform_moves!(move_seq)
    else
      raise "Invalid move sequence"
    end

    # self.board
  end

  def maybe_promote
    #red always starts at row 0
    if self.color == :red
      return true if self.pos[0] == 7
    else #it's black, which always starts at row 0
      return true if self.pos[0] == 0
    end

    return false
  end

  def perform_slide(end_pos)
    move(end_pos)
  end

  def perform_jump(end_pos)
    middle_pos = find_middle_pos(end_pos)
    remove_checker(middle_pos)
    move(end_pos)
  end

  def remove_checker(pos)
    @board[pos] = nil
  end

  #modifies the board
  def move(end_pos)
    # debugger
    start_piece = self
    self.board[end_pos] = start_piece
    end_piece = self.board[end_pos]
    self.board[start_piece.pos] = nil
    end_piece.pos = end_pos
    if end_piece.maybe_promote
      end_piece.king = true
    end
  end

  def move_diffs(color)
    #red is on top
    if color == :red
      return [[1,1],[1,-1]]
    else #black is on bottom
      return [[-1,-1],[-1,1]]
    end
  end

  def is_valid?(color)
    if self.color == color
      return true
    end

    false
  end


end
