class UpdateGameStatFreestyleResponseSentStems < ActiveRecord::Migration
  def change
    rename_column :game_stat_freestyle_response_sent_stems, :freestyle_response_sent_stem_id, :freestyle_sent_stem_id
    rename_table :game_stat_freestyle_response_sent_stems, :game_stat_freestyle_sent_stems
  end
end
