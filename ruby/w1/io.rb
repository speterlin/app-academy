#IO
require 'byebug'
#number guessing game
#computer chooses a number between 1 and 100
class GuessGame
  GUESSES = 10

  def initialize
    @secret_number = (1..100).to_a.sample
    @remaining_guesses = GUESSES
  end

  def play
    puts "Enter a number between 1 and 100"
    number = Integer(gets.chomp)
    until number.between?(1,100)
      puts "Invalid entry"
      number = Integer(gets.chomp)
    end
    until number == @secret_number || @remaining_guesses == 0
      if number < @secret_number
        puts "Number too low"
      else
        puts "Number too high"
      end
      @remaining_guesses -= 1
      puts "#{remaining_guesses}"
    end
    if number == @secret_number
      puts "You win"
    else
      puts "You lose, secret number is #{@secret_number}"
    end

  end

end

class ReadFile
  def initialize
  end

  def prompt
    puts "File name"
    file_name = gets.chomp
    lines = File.readlines(file_name).map(&:chomp).shuffle
    new_file_name = "#{file_name}-shuffled.txt"
    File.open(new_file_name,'w') do |file|
      file.puts lines
    end
  end
end


class RPNCalculator
  def initialize
    @stack = []
  end

  def calculate(args)
    # @stack = []
    # debugger
    str = read(args)
    str.split(/\s+/).each do |el|
      if el =~ /\+/
        # p el
        plus
      elsif el =~ /\-/
        # p el
        subtract
      elsif el =~ /\//
        # p el
        divide
      elsif el =~ /\*/
        # p el
        times
      else
        @stack << el.to_i
      end
    end
    p @stack.last

  end

  private

  def plus
    raise RuntimeError.new("Too few operands!") unless @stack.count >= 2
    @stack << @stack.pop + @stack.pop
  end

  def subtract
    raise RuntimeError.new("Too few operands!") unless @stack.count >= 2
    second = @stack.pop
    first = @stack.pop
    @stack << first - second
  end

  def divide
    raise RuntimeError.new("Too few operands!") unless @stack.count >= 2
    second = @stack.pop
    first = @stack.pop
    @stack << first.to_f / second
  end

  def times
    raise RuntimeError.new("Too few operands!") unless @stack.count >= 2
    second = @stack.pop
    first = @stack.pop
    @stack << first * second
  end

  def read(args)
    args.collect! do |arg|
      if arg =~ /.rb|.txt/
        lines = File.readlines(arg).map(&:chomp)
        arg = lines.join(" ")
      else
        arg
      end
    end
    str = args.join(" ")

    str
  end

end

# if ARGV
#   args = ARGV
#   RPNCalculator.new.calculate(args)
# end


if __FILE__ == $PROGRAM_NAME
  # provide file name on command line
  p __FILE__
  p $PROGRAM_NAME
  RPNCalculator.new.calculate(ARGV)
end
