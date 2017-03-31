class DestroyTableStudents < ActiveRecord::Migration
  def up
    drop_table "students", force: :cascade do |t|
      t.integer  "user_id",      null: false
      t.integer  "classroom_id", null: false
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end
  end

  def down
    create_table "students", force: :cascade do |t|
      t.integer  "user_id",      null: false
      t.integer  "classroom_id", null: false
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end
  end
end
