# == Schema Information
#
# Table name: ideologies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  direction  :string(255)
#  goal       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ideology < ActiveRecord::Base
  has_many(
    :parties,
    class_name: 'Party',
    foreign_key: :ideology_id,
    primary_key: :id
  )
  has_many(
    :subscribing_senators,
    through: :parties,
    source: :senators

  )
end
