class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.timestamps null: false
    end
    add_index :blogs, :title
  end
end
