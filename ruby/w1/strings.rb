require 'byebug'
require 'set'

class String
end

CHARS = {1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "A",
  11 => "B", 12 => "C", 13 => "D", 14 => "E", 15 => "F"}

def num_to_s(num, base)
  #returns a string representing the number in a different base
  i = 0
  divider = base ** i
  res = ""
  # debugger
  while divider < num
    val = (num/divider) % base
    char = CHARS[val]
    res = "#{char}#{res}"
    i+=1
    divider = base ** i
  end

  res
end

def caesar_cipher(str, shift)
  #text is all lower case letters
  #ord maps lowercase letter to number
  #str.ord
  # debugger
  str.split("").map do |char|
    ascii_val = char.ord
    new_ascii_val = ascii_val + shift
    new_ascii_val = new_ascii_val > 122 ? new_ascii_val - 122 + 96 : new_ascii_val
    new_char = new_ascii_val.chr
  end.join("")
end

# str = "hello"
# str = caesar_cipher(str,10)
# str = caesar_cipher(str,15)
# p str

if __FILE__ == $PROGRAM_NAME
  # provide file name on command line
  p caesar_cipher("hello",15)
end
