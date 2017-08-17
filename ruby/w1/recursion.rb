require 'byebug'
require 'set'

def range(start_num, end_num)
  return [] if start_num > end_num
  if end_num - start_num == 1
    return [start_num, end_num]
  end

  range(start_num,end_num-1) +[end_num]
end

def iter_array_sum(array)
  sum = 0
  array.each do |el|
    sum += el
  end

  sum
end

def arr_sum(arr)
  return arr[0] if arr.count == 1
  arr.last + arr_sum(arr[0..-2])

end



def exp1(b, n)
  return 1 if n == 0
  b * exp1(b, n-1)
end

# p exp1(2,3)

def exp2(b, n)
  return 1 if n == 0
  return b if n == 1
  return b * exp2(b, (n-1) / 2) * exp2(b, (n-1) / 2) if n.odd?
  return  exp2(b, n / 2) * exp2(b, n / 2) if n.even?
end


class Array

  def deep_dup (el = 0)
    map {|el| el.is_a?(Array) ? el.deep_dup : el}
  end
end





def bsearch(arr, target)
  return nil if arr.count == 0
  if arr.count == 1
    return target == arr[0] ? 0 : nil
  end

  middle_index = (arr.count / 2)

  if target == arr[middle_index]
    return middle_index
  end

  if target < arr[middle_index]
    bsearch(arr[0..middle_index-1], target)
  else
    result = bsearch(arr[middle_index..-1], target)
    if result
      middle_index + result
    else
      nil
    end

  end
end

# p bsearch([1, 2, 3], 1) # => 0

def make_change(trg,arr)
  return [] if trg == 0
  arr = arr.sort
  biggest_coin = arr.pop
  res = trg / biggest_coin
  rem = trg % biggest_coin
  first_sol = [biggest_coin]*res + make_change(rem,arr)

  i = arr.length - 1
  best_sol = first_sol
  while i >= 0
    next_sol = make_change(trg,arr[0..i])
    if next_sol.length < best_sol.length
      best_sol = next_sol
    end
    i-=1
  end

  best_sol
end

def merge_sort(arr)
  return [] if arr.length == 0
  middle = arr.length / 2
  left, right = arr.take(middle), arr.drop(middle)
  sorted_left, sorted_right = merge_sort(left), merge_sort(right)

  merge
end

def merge

end


def subsets(arr)
  return [[]] if arr.empty?
  return subsets(arr[0..-2]) + [[arr.last]] if arr.length == 1
  subsets(arr[0..-2]) + [[arr.last]] + subsets(arr[0..-2])[1..-1].collect! do |sub_arr|
    sub_arr << arr.last
  end

end
