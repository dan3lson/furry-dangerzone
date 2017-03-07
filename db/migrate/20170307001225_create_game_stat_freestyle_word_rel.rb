class CreateGameStatFreestyleWordRel < ActiveRecord::Migration
  def change
    create_table :game_stat_freestyle_word_rels do |t|
      t.integer :game_stat_id, null: false
      t.integer :freestyle_word_rel_id, null: false
      t.timestamps null: false
    end
  end
end
