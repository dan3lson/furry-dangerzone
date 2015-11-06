class AddColumnsFreestyleResponses < ActiveRecord::Migration
  def change
    add_column :freestyle_responses, :user_word_id, :integer
    add_column :freestyle_responses, :focus, :string
  end
end
