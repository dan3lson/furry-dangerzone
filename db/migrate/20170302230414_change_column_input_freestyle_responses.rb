class ChangeColumnInputFreestyleResponses < ActiveRecord::Migration
  def up
    change_column :freestyle_responses, :input, :text
  end

  def down
    change_column :freestyle_responses, :input, :string
  end
end
