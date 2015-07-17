class AddDefaultToSourceIdUserSources < ActiveRecord::Migration
  def up
    change_column_default :user_sources, :source_id, 1
  end

  def down
    change_column_default :user_sources, :source_id, nil
  end
end
