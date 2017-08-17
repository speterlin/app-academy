# == Schema Information
#
# Table name: desks
#
#  id         :integer          not null, primary key
#  model      :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Desk do
  it 'is owned by a senator' do
    elizabeth = Senator.find_by(lname: 'Warren')
    desk = Desk.find_by(owner_id: elizabeth.id)

    expect(desk.owner).to eq(elizabeth)
  end
end
