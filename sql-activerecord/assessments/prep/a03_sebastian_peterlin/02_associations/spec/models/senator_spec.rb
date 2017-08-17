# == Schema Information
#
# Table name: senators
#
#  id         :integer          not null, primary key
#  fname      :string(255)
#  lname      :string(255)
#  state      :string(255)
#  party_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Senator do
  subject(:john) { Senator.find_by(lname: 'McCain') }

  it 'is in a party' do
    expect(john.party.name).to eq('Republican Party')
  end

  it 'subscribes to an ideology' do
    expect(john.ideology.name).to eq('Conservatism')
  end

  it 'reports to a party leader' do
    expect(john.party_leader.lname).to eq('McConnell')
  end

  it 'has a desk' do
    expect(john.desk.model).to eq('IKEA Office (Oak)')
  end

  describe 'committee associations' do
    let(:foreign_relations) { Committee.find_by(name: 'Foreign Relations') }
    let(:finance) { Committee.find_by(name: 'Finance') }
    let(:johns_finance_membership) do
      CommitteeMembership.find_by(senator_id: john.id, committee_id: finance.id)
    end

    it 'has committee memberships' do
      expect(john.committee_memberships).to include(johns_finance_membership)
    end

    it 'can work on many committees' do
      expect(john.committees).to match_array([finance, foreign_relations])
    end

    it 'works with chairpersons' do
      expect(john.chairpersons.pluck(:lname)).
        to match_array(%w(Rubio Warren))
    end
  end

  describe 'chairperson' do
    subject(:elizabeth) { Senator.find_by(lname: 'Warren') }

    it 'leads a committee' do
      expect(elizabeth.committee_chaired.name).to eq('Finance')
    end
  end

  describe 'party leader' do
    subject(:mitch) { Senator.find_by(lname: 'McConnell') }

    it 'leads a party' do
      expect(mitch.party_led.name).to eq('Republican Party')
    end
  end
end
