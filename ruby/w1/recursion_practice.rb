def includes?(array,target)
  #does array include the integer
  return true if array[0] == target
  array.shift
  return false if array.length == 0
  includes?(array,target)
end

def num_occur(array,target)
  return 0 if array.length == 0
  count = 0
  count = 1 if target == array.last
  array.pop
  count + num_occur(array,target)
end

def add_to_twelve?(array)
  return false if array.length == 1
  return true if array.shift + array.first == 12
  add_to_twelve?(array)
end
