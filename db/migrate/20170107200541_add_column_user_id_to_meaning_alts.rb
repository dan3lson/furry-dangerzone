class AddColumnUserIdToMeaningAlts < ActiveRecord::Migration
  def change
    add_column :meaning_alts, :user_id, :integer
  end
end
