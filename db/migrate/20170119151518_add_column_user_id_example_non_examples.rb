class AddColumnUserIdExampleNonExamples < ActiveRecord::Migration
  def change
    add_column :example_non_examples, :user_id, :integer, null: false
  end
end
