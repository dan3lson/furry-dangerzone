class DropTableBlogPosts < ActiveRecord::Migration
  def up
    drop_table :blog_posts
  end

  def down
    create_table :blog_posts do |t|
      t.text :content, null: false
      t.string :title, null: false
      t.string :icon, null: false
      t.string :slug, null: false
      t.timestamps null: false
    end
  end
end
