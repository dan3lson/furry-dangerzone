class AddColumnFeedbackMeaningAlts < ActiveRecord::Migration
  def change
    add_column :meaning_alts, :feedback, :string, null: false
  end
end
