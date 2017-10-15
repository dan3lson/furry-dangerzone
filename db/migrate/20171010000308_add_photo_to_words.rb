class AddPhotoToWords < ActiveRecord::Migration
  def change
    add_column :words, :photo, :string
  end
end
