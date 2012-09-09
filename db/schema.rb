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

ActiveRecord::Schema.define(:version => 20120909072311) do

  create_table "accesses", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "parent_id",                 :null => false
    t.string   "controller"
    t.string   "action"
    t.integer  "panel",      :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name",                       :null => false
    t.text     "description"
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "access_profiles", :force => true do |t|
    t.integer  "access_id",                 :null => false
    t.integer  "profile_id",                :null => false
    t.integer  "deleted",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["access_id"], :name => "index_access_profiles_on_access_id"
    t.index ["profile_id"], :name => "index_access_profiles_on_profile_id"
    t.foreign_key ["access_id"], "accesses", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "access_profiles_ibfk_1"
    t.foreign_key ["profile_id"], "profiles", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "access_profiles_ibfk_2"
  end

  create_table "answer_formats", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "format",                    :null => false
    t.integer  "deleted",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_types", :force => true do |t|
    t.string   "name",                       :null => false
    t.text     "description"
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_levels", :force => true do |t|
    t.string   "range",      :null => false
    t.integer  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "lastname"
    t.integer  "deleted",                               :default => 0
    t.integer  "profile_id",                                            :null => false
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["profile_id"], :name => "index_users_on_profile_id"
    t.foreign_key ["profile_id"], "profiles", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "users_ibfk_1"
  end

  create_table "matches", :force => true do |t|
    t.string   "name",                             :null => false
    t.string   "url"
    t.integer  "started"
    t.integer  "match_type_id",                    :null => false
    t.integer  "question_level_id"
    t.integer  "deleted",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                          :null => false
    t.index ["match_type_id"], :name => "index_matches_on_match_type_id"
    t.index ["question_level_id"], :name => "index_matches_on_question_level_id"
    t.index ["user_id"], :name => "index_matches_on_user_id"
    t.foreign_key ["match_type_id"], "match_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "matches_ibfk_1"
    t.foreign_key ["question_level_id"], "question_levels", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "matches_ibfk_2"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "matches_ibfk_3"
  end

  create_table "question_types", :force => true do |t|
    t.string   "name",                       :null => false
    t.text     "description"
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.text     "question",                        :null => false
    t.string   "correct_answer"
    t.integer  "answer_format_id",                :null => false
    t.integer  "question_type_id"
    t.integer  "match_id",                        :null => false
    t.integer  "deleted",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["answer_format_id"], :name => "index_questions_on_answer_format_id"
    t.index ["question_type_id"], :name => "index_questions_on_question_type_id"
    t.index ["match_id"], :name => "index_questions_on_match_id"
    t.foreign_key ["answer_format_id"], "answer_formats", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "questions_ibfk_1"
    t.foreign_key ["question_type_id"], "question_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "questions_ibfk_2"
    t.foreign_key ["match_id"], "matches", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "questions_ibfk_3"
  end

  create_table "answers", :force => true do |t|
    t.text     "answer",                     :null => false
    t.integer  "is_correct",                 :null => false
    t.float    "percent"
    t.integer  "question_id",                :null => false
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["question_id"], :name => "index_answers_on_question_id"
    t.foreign_key ["question_id"], "questions", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "answers_ibfk_1"
  end

  create_table "companies", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "user_id",                   :null => false
    t.integer  "deleted",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_companies_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "companies_ibfk_1"
  end

  create_table "company_users", :force => true do |t|
    t.integer  "company_id",                :null => false
    t.integer  "user_id",                   :null => false
    t.integer  "deleted",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["company_id"], :name => "index_company_users_on_company_id"
    t.index ["user_id"], :name => "index_company_users_on_user_id"
    t.foreign_key ["company_id"], "companies", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "company_users_ibfk_1"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "company_users_ibfk_2"
  end

  create_table "exam_topics", :force => true do |t|
    t.string   "name",                       :null => false
    t.text     "description"
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.text     "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_logs_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "logs_ibfk_1"
  end

  create_table "question_type_exam_topics", :force => true do |t|
    t.integer  "question_type_id",                :null => false
    t.integer  "exam_topic_id",                   :null => false
    t.integer  "deleted",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["question_type_id"], :name => "index_question_type_exam_topics_on_question_type_id"
    t.index ["exam_topic_id"], :name => "index_question_type_exam_topics_on_exam_topic_id"
    t.foreign_key ["question_type_id"], "question_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "question_type_exam_topics_ibfk_1"
    t.foreign_key ["exam_topic_id"], "exam_topics", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "question_type_exam_topics_ibfk_2"
  end

end
