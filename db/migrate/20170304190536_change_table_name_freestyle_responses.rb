class ChangeTableNameFreestyleResponses < ActiveRecord::Migration
  def change
    rename_table :freestyle_responses, :freestyles
  end
end
