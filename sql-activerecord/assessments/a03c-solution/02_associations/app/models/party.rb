# == Schema Information
#
# Table name: parties
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  color           :string(255)
#  ideology_id     :integer
#  party_leader_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Party < ActiveRecord::Base
  belongs_to(
    :ideology,
    class_name: 'Ideology',
    foreign_key: :ideology_id,
    primary_key: :id
  )
  belongs_to(
    :party_leader,
    class_name: 'Senator',
    foreign_key: :party_leader_id,
    primary_key: :id
  )
  has_many(
    :senators,
    class_name: 'Senator',
    foreign_key: :party_id,
    primary_key: :id
  )
end

