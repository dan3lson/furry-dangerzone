class CreateGameLevels < ActiveRecord::Migration
  def change
    create_table :game_levels do |t|
      t.integer :game_id, null: false
      t.integer :level_id, null: false
      t.timestamps null: false
    end
  end
end
