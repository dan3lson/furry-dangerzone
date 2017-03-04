class CreateGameStatFreestyleResponseSentStems < ActiveRecord::Migration
  def change
    create_table :game_stat_freestyle_response_sent_stems do |t|
      t.integer :game_stat_id, null: false
      t.integer :freestyle_response_sent_stem_id, null: false
      t.timestamps null: false
    end
  end
end
