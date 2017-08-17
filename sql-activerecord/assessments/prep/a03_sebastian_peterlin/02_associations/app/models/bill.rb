# == Schema Information
#
# Table name: bills
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Bill < ActiveRecord::Base
  belongs_to(
    :author,
    class_name: 'Senator',
    foreign_key: :author_id,
    primary_key: :id
  )
  has_one(
    :sponsoring_party,
    through: :author,
    source: :party
  )
  has_many(
    :bill_endorsements,
    class_name: 'BillEndorsement',
    foreign_key: :bill_id,
    primary_key: :id
  )
  has_many(
    :endorsing_senators,
    through: :bill_endorsements,
    source: :senator
  )
end
