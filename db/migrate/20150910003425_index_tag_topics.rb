class IndexTagTopics < ActiveRecord::Migration
  def change
    add_index(:tag_topics, :topic, unique: true)
  end
end
