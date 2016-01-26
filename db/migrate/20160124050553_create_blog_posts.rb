class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :content, null: false
      t.string :title, null: false
      t.string :icon, null: false
      t.string :slug, null: false
      t.timestamps null: false
    end
    add_index :blog_posts, :title
    add_index :blog_posts, :slug
  end
end
