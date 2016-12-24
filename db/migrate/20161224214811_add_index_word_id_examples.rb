class AddIndexWordIdExamples < ActiveRecord::Migration
  def change
    add_index :examples, :word_id
  end
end
