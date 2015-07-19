class AddDefaultToSourceIdWordSources < ActiveRecord::Migration
  def up
    change_column_default :word_sources, :source_id, 1
  end

  def down
    change_column_default :word_sources, :source_id, nil
  end
end
