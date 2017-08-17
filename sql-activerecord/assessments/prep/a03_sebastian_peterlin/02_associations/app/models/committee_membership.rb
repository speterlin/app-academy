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

class CommitteeMembership < ActiveRecord::Base
  belongs_to(
    :senator,
    class_name: 'Senator',
    foreign_key: :senator_id,
    primary_key: :id
  )
  belongs_to(
    :committee,
    class_name: 'Committee',
    foreign_key: :committee_id,
    primary_key: :id
  )
end
