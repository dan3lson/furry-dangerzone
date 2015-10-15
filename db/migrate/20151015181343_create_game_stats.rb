class CreateGameStats < ActiveRecord::Migration
  def change
    create_table :game_stats do |t|
      t.integer :user_word_id, null: false
      t.integer :game_id, null: false
      t.integer :num_played, null: false, default: 0
      t.timestamps null: false
    end
    add_index :game_stats, [:user_word_id, :game_id], unique: true
  end
end
