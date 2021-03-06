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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110611235724) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "synopsis"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.integer  "author_id"
    t.string   "checksum"
    t.text     "body_html"
  end

  add_index "articles", ["author_id"], :name => "articles_authors_fk"

  create_table "articles_tags", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  add_index "articles_tags", ["article_id"], :name => "article_fk"
  add_index "articles_tags", ["tag_id"], :name => "tag_fk"

  create_table "authors", :force => true do |t|
    t.integer  "user_id"
    t.string   "pseudo_last"
    t.string   "pseudo_first"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["user_id"], :name => "authors_users_fk"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], :name => "articles_fk"
  add_index "comments", ["user_id"], :name => "users_fk"

  create_table "rights", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "tag_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "articles_count", :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "pass_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "last_name"
    t.string   "first_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
