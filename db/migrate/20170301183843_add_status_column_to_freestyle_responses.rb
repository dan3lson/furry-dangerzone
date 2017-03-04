class AddStatusColumnToFreestyleResponses < ActiveRecord::Migration
  def change
    add_column :freestyle_responses, :status, :string, default: "not reviewed"
  end
end
