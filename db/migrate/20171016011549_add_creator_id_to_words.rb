class AddCreatorIdToWords < ActiveRecord::Migration
  def change
    add_column :words, :creator_id, :integer
  end
end
