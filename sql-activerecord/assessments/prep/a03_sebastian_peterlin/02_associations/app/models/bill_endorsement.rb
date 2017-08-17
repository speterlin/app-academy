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

class BillEndorsement < ActiveRecord::Base
  belongs_to(
    :senator,
    class_name: 'Senator',
    foreign_key: :senator_id,
    primary_key: :id
  )
end
