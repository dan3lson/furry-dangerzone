class AddIndicesToWordSources < ActiveRecord::Migration
  def change
    add_index :word_sources, :word_id
    add_index :word_sources, :source_id
    add_index :word_sources, [:word_id, :source_id], unique: true
  end
end
