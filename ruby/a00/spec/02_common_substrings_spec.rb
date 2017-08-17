require '02_common_substrings'
require 'rspec'

# Write a function, `common_substrings(str1, str2)` that takes two
# strings and returns the longest common substring.
#
# NB: You may wish to use `String#include?`. To pull out a substring
# given a range, use `str[start..end]`.

#    e.g. common_substrings(
describe "#common_substrings" do
  it "finds a common substring" do
    expect(common_substrings("zooglensnuck", "lenscrafters")).to eq("lens")
  end

  it "finds a string at the end of a word" do
    expect(common_substrings("lazers", "wozers")).to eq("zers")
  end

  it "returns empty string if no common substring" do
    expect(common_substrings("abc", "xyz")).to eq("")
  end
end
