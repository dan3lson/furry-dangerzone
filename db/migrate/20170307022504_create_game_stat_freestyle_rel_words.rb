class CreateGameStatFreestyleRelWords < ActiveRecord::Migration
  def change
    create_table :game_stat_freestyle_rel_words do |t|
      t.integer :game_stat_id, null: false
      t.integer :freestyle_rel_word_id, null: false
      t.timestamps null: false
    end
  end
end
