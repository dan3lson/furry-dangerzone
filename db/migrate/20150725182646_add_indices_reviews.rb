class AddIndicesReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :user_id
    add_index :reviews, :version_id
    add_index :reviews, :rating
    add_index :reviews, [:user_id, :version_id], unique: true
  end
end
