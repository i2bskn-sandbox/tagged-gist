# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130711132328) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gists", force: true do |t|
    t.string   "gid"
    t.string   "description"
    t.string   "html_url"
    t.string   "embed_url"
    t.boolean  "public_gist"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gists", ["gid"], name: "index_gists_on_gid", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       limit: 20
    t.integer  "user_id"
    t.integer  "gist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "nickname"
    t.string   "email"
    t.string   "image_url"
    t.string   "github_url"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
