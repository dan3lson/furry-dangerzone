class ChangeColumnNullPartOfSpeechWords < ActiveRecord::Migration
  def change
    change_column_null :words, :part_of_speech, null: true
  end
end
