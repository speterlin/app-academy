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

class Senator < ActiveRecord::Base
  belongs_to(
    :party,
    class_name: 'Party',
    foreign_key: :party_id,
    primary_key: :id
  )
  has_one(
    :ideology,
    :through => :party,
    :source => :ideology
  )
  has_one(
    :party_leader,
    :through => :party,
    :source => :party_leader
  )
  has_one(
    :desk,
    class_name: 'Desk',
    foreign_key: :owner_id,
    primary_key: :id
  )
  has_many(
    :committee_memberships,
    class_name: 'CommitteeMembership',
    foreign_key: :senator_id,
    primary_key: :id
  )
  has_many(
    :committees,
    :through => :committee_memberships,
    :source => :committee
  )
  has_many(
    :chairpersons,
    :through => :committees,
    :source => :chairperson
  )

  # For chairpersons
  has_one(
    :committee_chaired,
    class_name: 'Committee',
    foreign_key: :chairperson_id,
    primary_key: :id
  )
  # For party leaders
  has_one(
    :party_led,
    class_name: 'Party',
    foreign_key: :party_leader_id,
    primary_key: :id
  )
end
