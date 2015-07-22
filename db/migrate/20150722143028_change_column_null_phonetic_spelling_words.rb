class ChangeColumnNullPhoneticSpellingWords < ActiveRecord::Migration
  def change
    change_column_null :words, :phonetic_spelling, null: true
  end
end
