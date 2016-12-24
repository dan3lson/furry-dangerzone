class CreateExamples < ActiveRecord::Migration
  def change
    drop_table :examples
    create_table :examples do |t|
      t.string :text, null: false
      t.integer :word_id, null: false
      t.timestamps null: false
    end
  end
end
