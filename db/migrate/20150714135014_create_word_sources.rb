class CreateWordSources < ActiveRecord::Migration
  def change
    create_table :word_sources do |t|
      t.integer :word_id, null: false
      t.integer :source_id, null: false
      t.timestamps null: false
    end
  end
end
