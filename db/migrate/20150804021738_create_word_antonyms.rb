class CreateWordAntonyms < ActiveRecord::Migration
  def change
    create_table :word_antonyms do |t|
      t.belongs_to :word, index: true, null: false
      t.belongs_to :antonym, index: true, null: false
      t.timestamps null: false
    end
    add_index :word_antonyms, [:word_id, :antonym_id], unique: true
  end
end
