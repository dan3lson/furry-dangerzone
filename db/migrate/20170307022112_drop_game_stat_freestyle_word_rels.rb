class DropGameStatFreestyleWordRels < ActiveRecord::Migration
  def change
    drop_table :game_stat_freestyle_rel_words do |t|
      t.integer :game_stat_id, null: false
      t.integer :freestyle_word_rel_id, null: false
      t.timestamps null: false
    end
  end
end
