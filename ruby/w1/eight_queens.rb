class EightQueens
  def initialize
    @board = Array.new(8) {Array.new(8)}
  end

  def solve
    (1..8).each do |n|
      if n.even? && n % 6 != 2
        (1..(n/2)).each do |col|
          col -=1 #indexed at 0
          @board[2*col][col] = :queen
          @board[(2*col)-1][(n/2)+col]
        end
      end
      if n.even? && n % 6 != 0
        (1..(n/2)).each do |col|
          @board[2*col][col] = :queen
          @board[(2*col)-1][(n/2)+col]
        end

  end
end
