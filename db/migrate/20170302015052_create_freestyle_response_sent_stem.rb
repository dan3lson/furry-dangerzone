class CreateFreestyleResponseSentStem < ActiveRecord::Migration
  def change
    create_table :freestyle_response_sent_stems do |t|
      t.integer :freestyle_response_id, null: false
      t.integer :sent_stem_id, null: false
      t.timestamps null: false
    end
  end
end
