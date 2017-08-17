class Array
  # def []=(row,col,value)
  #   # if self.first.is_a?(Array)
  #     self[row][col] = value
  #   # end
  # end

  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i+=1
    end

    self
  end
end

def my_transpose(array)
  (0..2).each do |row|
    start_idx = row
    (start_idx..2).each do |col|
      array[row][col], array[col][row] = array[col][row], array[row][col]
    end
  end

  array
end

# p my_transpose([[0, 1, 2],[3, 4, 5],[6, 7, 8]])
