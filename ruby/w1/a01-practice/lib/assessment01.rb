class Array
  def my_inject(accumulator = nil,&prc)
    if accumulator
      arr = self
    else
      arr = self[1..-1]
      accumulator = self[0]
    end
    arr.each do |val|
      accumulator = prc.call(accumulator,val)
    end

    accumulator
  end
end

def is_prime?(num)
  (2...num).none? {|factor| num % factor == 0 }
end

def primes(count)
  res = []
  n=2
  while res.length < count
    res << n if is_prime?(n)
    n+=1
  end

  res
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  #6 == [0!, 1!, 2!, 3!, 4!, 5!]
  return [1] if num == 1

  factorials_rec(num-1) + [(num-1) * factorials_rec(num-1).last]
end


class Array
  def dups
    positions = Hash.new {|h,k| h[k] = []}

    self.each.with_index do |el,idx|
      positions[el] << idx
    end

    positions.select {|key,value| value.count > 1}

  end
end

class String
  def symmetric_substrings
    res = []

    i = 0
    while i < self.length-1
      j = i+1
      while j < self.length
        sub_str = self[i..j]
        res << susb_str if sub_str == sub_str.reverse
        j+=1
      end
      i+=1
    end

    res
  end

end

#require 'byebug'

class Array
  def merge_sort(&prc) #code block turns it into a proc
    #base case are 0 and 1
    prc = proc {|num1,num2| num1 <=> num2} unless prc
    return self if self.count <= 1
    middle = self.count / 2
    left,right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort(&prc), right.merge_sort(&prc)


    Array.merge(sorted_left, sorted_right, &prc) #want prc to be a code block
  end


  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first,right.first)
      when 1
        merged << right.shift
      when 0
        merged << left.shift
      when -1
        merged << left.shift
      end

    end

    merged.concat(left)
    merged.concat(right)

    merged
  end
end

def quick_sort(arr)
  return arr if arr.count <= 1
  pivot = arr[0]
  left,right = arr[1..-1].partition{|el| el < pivot}
  quick_sort(left) + [pivot] + quick_sort(right)
end
