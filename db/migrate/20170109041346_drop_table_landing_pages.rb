class DropTableLandingPages < ActiveRecord::Migration
  def up
    drop_table :landing_pages
  end

  def down
    create_table :landing_pages do |t|
      t.string :target, null: false
      t.string :email, null: false
      t.timestamps null: false
    end
  end
end
