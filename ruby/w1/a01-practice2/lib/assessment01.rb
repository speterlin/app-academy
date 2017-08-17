require 'byebug'

class Array
  def my_inject(accumulator = nil,&prc)

    # accumulator = prc.call(accumulator,self[1])
    # debugger
    # array = self
    if accumulator
      array = self
    else
      accumulator = self[0]
      array = self[1..-1]
    end
    # array = self[1..-1] unless accumulator
    i = 0
    while i < array.length
      accumulator = prc.call(accumulator,array[i])
      i+=1
    end
    # array.each do |el|
    #   accumulator = prc.call(accumulator,el)
    # end

    accumulator
  end
end

def is_prime?(num)
  (2...num).none? {|factor| num % factor == 0}
end

def primes(count)
  res = []
  n = 2
  until res.length >= count
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
  return [1] if num == 1
  factorials_rec(num-1) << (num-1) * factorials_rec(num-1).last
end

class Array
  def dups
    hash = {}
    # debugger
    self.each.with_index do |el,idx|
      if hash.has_key?(el)
        hash[el] << idx
      else
        hash[el] = [idx]
      end
    end

    hash.select do |key,value|
      value.count > 1
    end
  end
end

class String
  def symmetric_substrings
    res = []
    i = 0
    while i < self.length-1
      j = i+1
      while j <self.length
        if self[i..j] == self[i..j].reverse
          res << self[i..j]
        end
        j+=1
      end
      i+=1
    end

    res
  end
end

class Array
  def merge_sort(&prc)
    return self if self.length <= 1
    middle = self.length / 2
    left, right = self.take(middle), self.drop(middle)
    sorted_left, sorted_right = left.merge_sort, right.merge_sort

    prc = proc {|num1,num2| num1 <=> num2} unless prc

    Array.merge(sorted_left, sorted_right, prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      case prc.call(left.first,right.first)
      when 1
        merged << right.first
      when 0
        merged << left.first
      when -1
        merged << left.first
      end
    end
    merged.concat(left)
    merged.concat(right)

    merged
  end
end

# p is_prime?(7)
# # p is_prime?(8)
# p primes(5)
# p [1,2,0,1,2].dups
