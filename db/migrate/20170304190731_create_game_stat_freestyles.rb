class CreateGameStatFreestyles < ActiveRecord::Migration
  def change
    create_table :game_stat_freestyles do |t|
      t.belongs_to :game_stat,
                   null: false,
                   unique: true,
                   index: true,
                   foreign_key: true
      t.belongs_to :freestyle,
                   null: false,
                   unique: true,
                   index: true,
                   foreign_key: true
      t.timestamps null: false
    end
  end
end
