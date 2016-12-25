class CreateMeaningAlts < ActiveRecord::Migration
  def change
    create_table :meaning_alts do |t|
      t.string :text, null: false
      t.integer :word_id, null: false
      t.timestamps null: false
    end
  end
end
