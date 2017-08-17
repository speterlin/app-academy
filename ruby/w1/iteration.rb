require 'set'
require 'byebug'

def factors(num)
  (2...num).select do |factor|
    num if num % factor == 0
  end
end

def bubble_sort(array)
  sorted = false
  until sorted
    sorted = true
    array[0..-2].each_index do |idx|
      if array[idx] > array[idx+1]
        array[idx], array[idx+1] = array[idx+1], array[idx]
        sorted = false
      end
    end
  end

  array
end


def substrings(string)
  end_index = string.length
  [].tap do |new_arr|
    (0...end_index).each do |idx|
      start_index = idx
      (start_index...end_index).each do |next_idx|
        new_arr << string[idx..next_idx]
      end
    end
  end

end

def sub_words(string)
  dictionary = Set.new(File.readlines('dictionary.txt').map(&:chomp))
  substrings(string).select do |sub_str|
    dictionary.include?(sub_str)
  end
end
