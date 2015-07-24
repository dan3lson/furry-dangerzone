class ChangeSourceToTag < ActiveRecord::Migration
  def change
    rename_table :sources, :tags
    rename_table :user_sources, :user_tags
    rename_table :user_word_sources, :user_word_tags
    rename_table :word_sources, :word_tags
    rename_column :user_tags, :source_id, :tag_id
    rename_column :user_word_tags, :word_source_id, :word_tag_id
    rename_column :word_tags, :source_id, :tag_id
  end
end
