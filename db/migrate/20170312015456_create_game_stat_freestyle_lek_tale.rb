class CreateGameStatFreestyleLekTale < ActiveRecord::Migration
  def change
    create_table :game_stat_freestyle_lek_tales do |t|
      t.integer :game_stat_id, null: false
      t.integer :freestyle_lek_tale_id, null: false
      t.timestamps null: false
    end
  end
end
