class UpdateFreestyleResponseSentStems < ActiveRecord::Migration
  def change
    rename_column :freestyle_response_sent_stems, :freestyle_response_id, :freestyle_id
    rename_table :freestyle_response_sent_stems, :freestyle_sent_stems
    add_index :freestyle_sent_stems, :freestyle_id
    add_index :freestyle_sent_stems, :sent_stem_id
  end
end
