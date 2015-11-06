class DropTableLevels < ActiveRecord::Migration
  def change
    drop_table :levels
    drop_table :game_levels
    drop_table :user_word_game_levels
    drop_table :source_lists
    drop_table :word_lists
    remove_column :freestyle_responses, :user_word_game_level_id,
      :integer
  end
end
