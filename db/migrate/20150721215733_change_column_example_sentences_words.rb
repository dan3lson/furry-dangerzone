class ChangeColumnExampleSentencesWords < ActiveRecord::Migration
  def change
    change_column_null :words, :example_sentence, null: true
  end
end
