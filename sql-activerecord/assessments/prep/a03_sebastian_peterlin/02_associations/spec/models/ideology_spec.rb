# == Schema Information
#
# Table name: ideologies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  direction  :string(255)
#  goal       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Ideology do
  it 'is supported by parties' do
    liberalism = Ideology.find_by(name: 'Liberalism')
    democrats = Party.find_by(name: 'Democratic Party')

    expect(liberalism.parties).to eq([democrats])
  end

  it 'has subscribing senators' do
    conservatism = Ideology.find_by(name: 'Conservatism')

    expect(conservatism.subscribing_senators.pluck(:lname)).
      to match_array(%w(McCain McConnell Rubio))
  end
end
