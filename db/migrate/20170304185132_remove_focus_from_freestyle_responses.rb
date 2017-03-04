class RemoveFocusFromFreestyleResponses < ActiveRecord::Migration
  def change
    remove_column :freestyle_responses, :focus, :string
  end
end
