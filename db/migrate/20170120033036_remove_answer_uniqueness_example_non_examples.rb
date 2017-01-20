class RemoveAnswerUniquenessExampleNonExamples < ActiveRecord::Migration
  def change
    remove_index :example_non_examples, column: :answer
    add_index :example_non_examples, :answer
  end
end
