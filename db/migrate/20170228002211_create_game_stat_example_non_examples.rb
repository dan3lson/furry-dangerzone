class CreateGameStatExampleNonExamples < ActiveRecord::Migration
  def change
    create_table :game_stat_example_non_examples do |t|
      t.integer :game_stat_id, null: false
      t.integer :example_non_example_id, null: false
      t.timestamps null: false
    end
  end
end
