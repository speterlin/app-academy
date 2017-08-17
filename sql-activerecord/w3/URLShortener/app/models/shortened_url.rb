class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :presence => true, length: { maximum: 255 }
  validates :short_url, :presence => true, :uniqueness => true
  validates :submitter_id, :presence => true
  validate :method_name
  

  #
  # belongs_to(
  #   :submitter,
  #   class_name: 'User',
  #   foreign_key: :submitter_id,
  #   primary_key: :id
  # )
  # has_many(
  #   :visits,
  #   class_name: 'Visit',
  #   foreign_key: :shortened_url_id,
  #   primary_key: :id
  # )
  # has_many(
  #   :visitors,
  #   Proc.new { distinct },
  #   through: :visits,
  #   source: :visitor
  # )
  # has_many(
  #   :taggings,
  #   class_name: 'Tagging',
  #   foreign_key: :shortened_url_id,
  #   primary_key: :id
  # )
  # has_many(
  #   :tagged_topics,
  #   through: :taggings,
  #   source: :tag_topic
  # )




  def self.random_code
    random = SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom::urlsafe_base64
    end

    random
  end

  def self.create_for_user_and_long_url!(user,long_url)
    ShortenedUrl.create!(submitter_id: user.id,long_url: long_url,short_url: ShortenedUrl.random_code)
  end
  #
  # def num_clicks
  #   visits.count
  # end
  #
  # def num_uniques
  #   visitors.count
  # end
  #
  # def valid_abuse
  #   number_of_entries = Visit.
  #     where("created_at >= ?", 1.minutes.ago).
  #     select(:submitter_id).
  #     count
  #   return false if number_of_entries > 5
  #   true
  # end
  #
  # def num_recent_uniques
  #   Visit.
  #     where("created_at >= ?", 10.minutes.ago).
  #     select(:visitor_id).
  #     distinct.
  #     count
  # end
end
