class AddIndicesExampleNonExamples < ActiveRecord::Migration
  def change
    add_index :example_non_examples, :user_id
    add_index :example_non_examples, :text, unique: true
    add_index :example_non_examples, :answer, unique: true
    add_index :example_non_examples, :feedback, unique: true
    add_index :example_non_examples, [:text, :answer, :feedback], unique: true
  end
end
