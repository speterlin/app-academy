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

class Committee < ActiveRecord::Base
  belongs_to(
    :chairperson,
    class_name: 'Senator',
    foreign_key: :chairperson_id,
    primary_key: :id
  )
  has_many(
    :memberships,
    class_name: 'CommitteeMembership',
    foreign_key: :committee_id,
    primary_key: :id
  )
  has_many(
    :senators,
    :through => :memberships,
    :source => :senator
  )
end

