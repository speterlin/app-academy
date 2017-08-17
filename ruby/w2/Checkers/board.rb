class Board

  attr_accessor :cursor

  def initialize(set_checkers = true)
    @grid = Array.new(8) {Array.new(8) } #fill it with pieces
    create_checkers if set_checkers
    @cursor = [0,3]
  end

  def render
    (0..7).map do |row|
      (0..7).map do |col|
        pos = [row,col]
        if row.even? && col.even? || row.odd? && col.odd?
          if self[pos] == nil
            "     ".colorize(:background => :white)
          else
            "  #{self[pos].render}  ".colorize(:background => :white)
          end
        else
          if self[pos] == nil
             "     ".colorize(:background => :yellow)
           else
             "  #{self[pos].render}  ".colorize(:background => :yellow)
           end
        end
      end.join("")
    end.join("\n")
  end

  def pieces(color)
    @grid.flatten.compact.select { |p| p.color == color }
  end

  def over?
    pieces(:red).none? || pieces(:black).none?
  end


  def create_checkers
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row,col]
        if row == 0 && col.even? || row == 2 && col.even?
          self[pos] = Piece.new([row,col], :red, self)
        elsif row == 1 && col.odd?
          self[pos] = Piece.new([row,col], :red, self)
        elsif row == 5 && col.odd? || row == 7 && col.odd?
          self[pos] = Piece.new([row,col], :black, self)
        elsif row == 6 && col.even?
          self[pos] = Piece.new([row,col], :black, self)
        end
      end
    end
  end

  def deep_dup
    new_board = Board.new(false)
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row,col]
        old_piece = self[pos]
        if old_piece
          new_board[pos] = Piece.new(old_piece.pos.dup, old_piece.color, new_board)
        end
      end
    end

    new_board
  end

  def on_board?(pos)
    i,j = pos
    i.between?(0,7) && j.between?(0,7)
  end

  def won?(color)

  end

  def is_valid?(pos)
    raise "Invalid input quantity" if pos.size < 2
    raise "Non-numeric values" if pos.any? {|el| !el.is_a?(Fixnum)}
    raise 'Not on board' unless on_board?(pos)
    true
  end


  def []=(pos,piece)
    is_valid?(pos)
    i, j = pos
    @grid[i][j] = piece
  end

  def [](pos)
    is_valid?(pos)
    i, j = pos
    @grid[i][j]
  end

end
