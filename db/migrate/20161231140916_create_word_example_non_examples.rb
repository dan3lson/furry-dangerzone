class CreateWordExampleNonExamples < ActiveRecord::Migration
  def change
    create_table :word_example_non_examples do |t|
      t.integer :word_id, null: false
      t.integer :example_non_example_id, null: false
      t.timestamps null: false
    end
    add_index :word_example_non_examples, :word_id
    add_index :word_example_non_examples, :example_non_example_id
    add_index :word_example_non_examples, [:word_id,  :example_non_example_id], name: :index_word_example_non_examples_foreign_keys
  end
end
