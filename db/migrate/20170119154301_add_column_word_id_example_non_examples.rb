class AddColumnWordIdExampleNonExamples < ActiveRecord::Migration
  def change
    add_column :example_non_examples, :word_id, :integer, null: false
  end
end
