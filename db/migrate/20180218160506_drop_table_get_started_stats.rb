class DropTableGetStartedStats < ActiveRecord::Migration
  def change
    drop_table "get_started_stats", force: :cascade do |t|
      t.integer  "get_started_top_btn",              default: 0
      t.integer  "get_started_btm_btn",              default: 0
      t.integer  "get_started_skip_btn",             default: 0
      t.integer  "get_started_goal_cont_btn",        default: 0
      t.integer  "get_started_goal_skip_btn",        default: 0
      t.integer  "get_started_mastery_circle_btn",   default: 0
      t.integer  "get_started_finish_btn",           default: 0
      t.integer  "get_started_save_my_progress_btn", default: 0
      t.integer  "get_started_create_my_acct_btn",   default: 0
      t.datetime "created_at",                                   null: false
      t.datetime "updated_at",                                   null: false
    end
  end
end
