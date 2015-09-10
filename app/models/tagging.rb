class Tagging < ActiveRecord::Base

  belongs_to(
    :short_url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
  )

  belongs_to(
    :tag_topic,
    class_name: "TagTopic",
    foreign_key: :tag_id,
    primary_key: :id
  )

  def self.record_tag!(url, tag) # takes a shorturl string or id and tag string
    url_id = ShortenedUrl.find_by_short_url(url).id if url.is_a?(String)
    url_id = url.id if url.is_a?(ShortenedUrl)
    tag_id = TagTopic.find_by_topic(tag).id
    Tagging.create!(url_id: url_id, tag_id: tag_id)
  end

end
