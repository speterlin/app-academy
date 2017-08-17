
class ScrabbleHelper
  attr_reader :matches

  def initialize
    words = File.readlines("dictionary.txt").map(&:chomp)
    specs = ("awebtgcuo").split("")
    @matches = []
    words.each do |word|
      letters = word.split("")

      if ((word =~ /[dfhijklmnpqrsxyz]/).nil? && word.length <= 8)
      #if ((word.scan(/t/).length <= 2) && !(word =~ /[bsyoef]{1}/).nil? && word.length <= 8)
        #word.include?("b") && word.include?("s") && word.include?("y") && word.include?("o") && word.include?("e")  && word.include?("f")
        @matches << word
      end
    end

  end

end

sh = ScrabbleHelper.new

puts sh.matches
