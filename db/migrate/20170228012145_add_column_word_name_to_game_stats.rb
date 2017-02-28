class AddColumnWordNameToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :word_name, :string
  end
end
