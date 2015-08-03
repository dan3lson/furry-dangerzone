class CreateWordSynonym < ActiveRecord::Migration
  def change
    create_table :word_synonyms do |t|
      t.belongs_to :word, index: true, null: false
      t.belongs_to :synonym, index: true, null: false
      t.timestamps null: false
    end
    add_index :word_synonyms, [:word_id, :synonym_id], unique: true
  end
end
