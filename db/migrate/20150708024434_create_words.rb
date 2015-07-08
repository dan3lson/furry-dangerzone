class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :definition, null: false
      t.string :pronunciation, null: false
      t.string :part_of_speech, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
