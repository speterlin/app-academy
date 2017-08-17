# == Schema Information
#
# Table name: committee_memberships
#
#  id           :integer          not null, primary key
#  senator_id   :integer
#  committee_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe CommitteeMembership do
  let(:dianne) { Senator.find_by(lname: 'Feinstein') }
  let(:finance) { Committee.find_by(name: 'Finance') }

  subject(:diannes_finance_membership) do
    CommitteeMembership.find_by(
      senator_id: dianne.id,
      committee_id: finance.id)
  end

  it 'is associated with a senator' do
    expect(diannes_finance_membership.senator).to eq(dianne)
  end

  it 'is associated with a committee' do
    expect(diannes_finance_membership.committee).to eq(finance)
  end
end
