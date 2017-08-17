require '03_fibonacci'
require 'rspec'

# Write a function, `fibs(num)` which returns a given number of
# elements from the fibonnacci sequence
# (http://en.wikipedia.org/wiki/Fibonacci_number). In the sequence,
# each next number is the sum of the two preceding numbers.

describe "#fibs" do
  it "returns the first fib" do
    expect(fibs(1)).to eq([0])
  end

  it "returns the first two fibs" do
    expect(fibs(2)).to eq([0, 1])
  end

  it "returns many fibs" do
    expect(fibs(7)).to eq([ 0, 1, 1, 2, 3, 5, 8 ])
  end

  it "returns no fibs" do
    expect(fibs(0)).to eq([])
  end
end
