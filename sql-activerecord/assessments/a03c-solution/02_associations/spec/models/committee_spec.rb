# == Schema Information
#
# Table name: committees
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  mandate        :string(255)
#  chairperson_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Committee do
  subject(:finance) { Committee.find_by(name: 'Finance') }

  it 'is led by a chairperson' do
    expect(finance.chairperson.lname).to eq('Warren')
  end

  it 'has memberships' do
    john = Senator.find_by(lname: 'McCain')
    johns_finance_membership =
      CommitteeMembership.find_by(
        senator_id: john.id,
        committee_id: finance.id)

    expect(finance.memberships).to include(johns_finance_membership)
  end

  it 'has senators assigned to it' do
    expect(finance.senators.pluck(:lname)).
      to match_array(%w(Boxer Feinstein McCain Warren))
  end
end
