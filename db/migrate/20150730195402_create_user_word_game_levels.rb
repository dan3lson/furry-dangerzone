class CreateUserWordGameLevels < ActiveRecord::Migration
  def change
    create_table :user_word_game_levels do |t|
      t.integer :user_word_id, null: false
      t.integer :game_level_id, null: false
      t.string :status, null: false, default: "not started"
      t.timestamps null: false
    end
  end
end
