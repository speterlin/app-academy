# == Schema Information
#
# Table name: bill_endorsements
#
#  id         :integer          not null, primary key
#  bill_id    :integer
#  senator_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe BillEndorsement do
  it 'is associated with a senator' do
    bag_ban = Bill.find_by(title: 'Ban plastic bags.')
    barbara = Senator.find_by(lname: 'Boxer')
    barbaras_bag_endorsement = BillEndorsement.find_by(
      bill_id: bag_ban.id,
      senator_id: barbara.id)

    expect(barbaras_bag_endorsement.senator).to eq(barbara)
  end
end
