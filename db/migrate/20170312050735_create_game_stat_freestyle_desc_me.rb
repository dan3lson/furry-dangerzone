class CreateGameStatFreestyleDescMe < ActiveRecord::Migration
  def change
    create_table :game_stat_freestyle_desc_mes do |t|
      t.integer :game_stat_id, null: false, index: true
      t.integer :freestyle_desc_me_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
