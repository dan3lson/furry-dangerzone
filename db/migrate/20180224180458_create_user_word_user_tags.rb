class CreateUserWordUserTags < ActiveRecord::Migration
  def change
    create_table :user_word_user_tags do |t|
      t.integer :user_word_id, null: false
      t.integer :user_tag_id, null: false
      t.timestamps null: false
    end

    add_index :user_word_user_tags, :user_word_id
    add_index :user_word_user_tags, :user_tag_id
    add_index :user_word_user_tags, [:user_word_id, :user_tag_id], unique: true
  end
end
