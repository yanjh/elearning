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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120905032940) do

  create_table "announcements", :force => true do |t|
    t.text     "headline"
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "cexams", :force => true do |t|
    t.integer  "chapter_id"
    t.string   "name"
    t.text     "description"
    t.integer  "etype"
    t.integer  "status"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapters", :force => true do |t|
    t.integer  "corder"
    t.string   "cpcode"
    t.string   "title"
    t.text     "content"
    t.text     "description"
    t.integer  "status"
    t.integer  "cid"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classusers", :force => true do |t|
    t.integer  "sclass_id"
    t.integer  "user_id"
    t.string   "username"
    t.string   "sclassname"
    t.integer  "ltype"
    t.string   "onumber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classusers", ["sclass_id", "user_id", "ltype"], :name => "index_classusers_on_sclass_id_and_user_id_and_ltype", :unique => true

  create_table "courses", :force => true do |t|
    t.integer  "ctype"
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.integer  "state"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "status"
    t.string   "ccode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "grades", :force => true do |t|
    t.string   "name"
    t.integer  "gyear"
    t.integer  "status"
    t.integer  "stype"
    t.text     "address"
    t.string   "geocode"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mlinks", :force => true do |t|
    t.integer  "id1"
    t.string   "name1"
    t.string   "order1"
    t.integer  "id2"
    t.string   "name2"
    t.string   "order2"
    t.integer  "ltype"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mlinks", ["id1", "id2", "ltype"], :name => "index_mlinks_on_id1_and_id2_and_ltype", :unique => true

  create_table "problems", :force => true do |t|
    t.string   "pcode"
    t.integer  "owner"
    t.string   "ownername"
    t.text     "title"
    t.text     "content"
    t.text     "description"
    t.string   "answer"
    t.string   "tags"
    t.integer  "ptype"
    t.integer  "ctype"
    t.integer  "status"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "real_name"
    t.string   "location"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_email"
  end

  create_table "questions", :force => true do |t|
    t.integer  "cexam_id"
    t.integer  "problem_id"
    t.integer  "score"
    t.integer  "pcode"
    t.integer  "qorder"
    t.string   "title"
    t.integer  "ptype"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sclasses", :force => true do |t|
    t.string   "name"
    t.integer  "grade_id"
    t.integer  "status"
    t.integer  "ctype"
    t.text     "address"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seresults", :force => true do |t|
    t.integer  "student_id"
    t.string   "student_name"
    t.integer  "exam_id"
    t.integer  "etype"
    t.text     "answer"
    t.integer  "score"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "label"
    t.string   "identifier"
    t.text     "description"
    t.string   "field_type",  :default => "string"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sqresults", :force => true do |t|
    t.integer  "student_id"
    t.string   "student_name"
    t.integer  "question_id"
    t.integer  "ptype"
    t.string   "answer"
    t.integer  "score"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                :limit => 100
    t.string   "encrypted_password",   :limit => 128, :default => "",        :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "login",                :limit => 40
    t.string   "identity_url"
    t.string   "name",                 :limit => 100, :default => ""
    t.string   "sname",                :limit => 100, :default => ""
    t.string   "ucode",                :limit => 100, :default => ""
    t.string   "state",                               :default => "passive"
    t.string   "twitter_token"
    t.string   "xmpp_token"
    t.string   "language",                            :default => "cn"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
