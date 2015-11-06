class ChangeColumnNullFreestyleResponses < ActiveRecord::Migration
  def change
    change_column_null :freestyle_responses,
      :user_word_game_level_id, null: true
  end
end
