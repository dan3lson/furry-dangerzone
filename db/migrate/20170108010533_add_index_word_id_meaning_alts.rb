class AddIndexWordIdMeaningAlts < ActiveRecord::Migration
  def change
    add_index :meaning_alts, :word_id
    add_index :meaning_alts, [:word_id, :text], unique: true
  end
end
