class AddIndicesUserTags < ActiveRecord::Migration
  def change
    add_index :user_tags, :user_id
    add_index :user_tags, :tag_id
    add_index :user_tags, [:user_id, :tag_id], unique: true
  end
end
