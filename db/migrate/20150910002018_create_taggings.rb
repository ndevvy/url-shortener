class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :url_id

      t.timestamps
    end

    create_table :tag_topics do |t|
      t.string :topic

      t.timestamps
    end

  add_index(:taggings, :tag_id)
  add_index(:taggings, :url_id)

  end
end
