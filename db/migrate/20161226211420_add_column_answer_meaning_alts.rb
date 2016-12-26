class AddColumnAnswerMeaningAlts < ActiveRecord::Migration
  def change
    add_column :meaning_alts, :answer, :string, null: false
  end
end
