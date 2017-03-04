class ChangeColumnsToNullFreestyles < ActiveRecord::Migration
  def change
    change_column_null :freestyles, :status, false
    change_column_null :freestyles, :user_word_id, false
  end
end
