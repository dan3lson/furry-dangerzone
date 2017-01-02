class CreateExampleNonExamples < ActiveRecord::Migration
  def change
    create_table :example_non_examples do |t|
      t.string :text, null: false
      t.string :answer, null: false
      t.string :feedback, null: false
      t.timestamps null: false
    end
  end
end
