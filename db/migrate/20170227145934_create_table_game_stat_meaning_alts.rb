class CreateTableGameStatMeaningAlts < ActiveRecord::Migration
  def change
    create_table :game_stat_meaning_alts do |t|
      t.integer :game_stat_id, null: false
      t.integer :meaning_alt_id, null: false
      t.timestamps null: false
    end
  end
end
