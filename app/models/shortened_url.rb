require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
  )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  def self.random_code
    random = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64
    end

    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(user_id: user, long_url: long_url, short_url: ShortenedUrl.random_code)
  end

  def self.return_long_url_string_from_short_url(short_url)
    self.find_by_short_url(short_url).long_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(user_id).distinct.where(created_at < 10.minutes.ago).count
  end

end
