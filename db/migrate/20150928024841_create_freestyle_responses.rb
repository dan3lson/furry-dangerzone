class CreateFreestyleResponses < ActiveRecord::Migration
  def change
    create_table :freestyle_responses do |t|
      t.string :input, null: false
      t.belongs_to :user_word_game_level, null: false, index: true
      t.timestamps null: false
    end
    add_index :freestyle_responses,
              [:input, :user_word_game_level_id],
              unique: true
  end
end
