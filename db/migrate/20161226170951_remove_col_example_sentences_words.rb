class RemoveColExampleSentencesWords < ActiveRecord::Migration
  def change
    remove_column :words, :example_sentence, :string
  end
end
