require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < self.count
      prc.call(self[i])
      i += 1
    end

    self
  end

  def my_map(&prc)

    [].tap do |arr|
      i = 0
      while i < self.count
        arr << prc.call(self[i])
        i += 1
      end
    end

  end

  def my_select(&prc)
    arr = []

    i = 0
    while i < self.count
      arr << self[i] if prc.call(self[i])
      i += 1
    end
    arr
  end

  def my_inject(&prc)
    sum = self[0]
    self[1..self.length-1].my_each do |val|
      sum = prc.call(sum, val)
    end
    sum

  end

  def my_sort!(&prc)
    sorted = false
    until sorted
      sorted = true

      self[0..-2].each_index do |indx|
        if prc.call( self[indx], self[indx +1] ) == 1
          sorted = false
          self[indx] , self[indx + 1] = self[indx + 1], self[indx]
        end
      end

    end
    self
  end

end

# def eval_block(*args, &prc)
#   unless block_given?
#     puts "NO BLOCK GIVEN"
#     return
#   end
#
#   prc.call(args)
# end
#
# eval_block("Kerry", "Washington", 23) do |fname, lname, score|
#   puts "#{lname}, #{fname} won #{score} votes."
# end

proc_add_1 = Proc.new {|num| num + 1}
proc_add_2 = proc {|num| num + 2}
proc_add_3 = lambda {|num| return 3}


def chain_blocks(start_val, proc1, proc2, proc3)
  # debugger
  val1 = proc1.call(start_val) #2
  val2 = proc2.call(val1) #4
  val3 = proc3.call(val2) #7

  val3
end

val = chain_blocks(1, proc_add_1, proc_add_2,proc_add_3) #do |num|
#   return 4
# end

p val
