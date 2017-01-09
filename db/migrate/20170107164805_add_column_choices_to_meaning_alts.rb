class AddColumnChoicesToMeaningAlts < ActiveRecord::Migration
  def change
    add_column :meaning_alts, :choices, :string
  end
end
