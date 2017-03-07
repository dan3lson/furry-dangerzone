class DropGameStatFreestyleWordRelsTwo < ActiveRecord::Migration
  def change
    drop_table :game_stat_freestyle_word_rels do |t|
      t.integer :game_stat_id, null: false
      t.integer :freestyle_rel_word_id, null: false
      t.timestamps null: false
    end
  end
end
