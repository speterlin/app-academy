require 'byebug'

WINS = [["Paper","Rock"],["Rock","Scissors"],["Scissors","Paper"]]
CHOICES = ["Rock","Paper","Scissors"]
def rps(human_choice)
  #return computer's choice
  computer_choice = CHOICES.sample
  if WINS.include?([human_choice,computer_choice])
    str = "#{computer_choice}, Win"
  elsif human_choice == computer_choice
    str = "#{computer_choice}, Draw"
  else
    str = "#{computer_choice}, Lose"
  end

  str
end

#mixology game


def remix(drink_combos)
  alcohols = []
  mixes = []
  # debugger
  drink_combos.each do |drink_combo|
    alcohols << drink_combo.first
    mixes << drink_combo.last
  end
  alcohols.shuffle!
  mixes.shuffle
  [].tap do |new_mixes|
    3.times do |idx|
      new_mixes << [alcohols[idx], mixes[idx]]
    end
  end
end

drink_combos = [["rum", "coke"],["gin", "tonic"],["scotch", "soda"]]
p remix(drink_combos)
