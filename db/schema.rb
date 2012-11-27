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

ActiveRecord::Schema.define(:version => 20121116212410) do

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
    t.string   "name",                           :null => false
    t.string   "format",                         :null => false
    t.integer  "deleted",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enable_to_exams", :default => 1
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
    t.integer  "profile_id",                            :default => 2,  :null => false
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["profile_id"], :name => "index_users_on_profile_id"
    t.foreign_key ["profile_id"], "profiles", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "users_ibfk_1"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                   :null => false
    t.integer  "deleted",    :default => 0
    t.index ["user_id"], :name => "index_courses_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "courses_ibfk_1"
  end

  create_table "match_types", :force => true do |t|
    t.string   "name",                       :null => false
    t.text     "description"
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_levels", :force => true do |t|
    t.string   "range",                     :null => false
    t.integer  "deleted",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.string   "name",                             :null => false
    t.string   "url"
    t.integer  "started",           :default => 0
    t.integer  "match_type_id",                    :null => false
    t.integer  "question_level_id"
    t.integer  "deleted",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                          :null => false
    t.string   "pdf_url"
    t.integer  "course_id"
    t.index ["match_type_id"], :name => "index_matches_on_match_type_id"
    t.index ["question_level_id"], :name => "index_matches_on_question_level_id"
    t.index ["user_id"], :name => "index_matches_on_user_id"
    t.index ["course_id"], :name => "index_matches_on_course_id"
    t.foreign_key ["course_id"], "courses", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "matches_ibfk_4"
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
    t.integer  "obligatory",       :default => 1, :null => false
    t.float    "weight"
    t.index ["answer_format_id"], :name => "index_questions_on_answer_format_id"
    t.index ["question_type_id"], :name => "index_questions_on_question_type_id"
    t.index ["match_id"], :name => "index_questions_on_match_id"
    t.foreign_key ["answer_format_id"], "answer_formats", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "questions_ibfk_1"
    t.foreign_key ["question_type_id"], "question_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "questions_ibfk_2"
    t.foreign_key ["match_id"], "matches", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "questions_ibfk_3"
  end

  create_table "answers", :force => true do |t|
    t.text     "answer",                     :null => false
    t.string   "is_correct"
    t.float    "percent"
    t.integer  "question_id",                :null => false
    t.integer  "deleted",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position"
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

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "panel_billings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "country_id"
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "cardholder_first_name"
    t.string   "cardholder_last_name"
    t.integer  "number"
    t.integer  "cvv"
    t.datetime "exp_date"
    t.string   "billing_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_panel_billings_on_user_id"
    t.index ["country_id"], :name => "index_panel_billings_on_country_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_billings_ibfk_1"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_billings_ibfk_2"
  end

  create_table "panel_plans", :force => true do |t|
    t.string   "name"
    t.decimal  "amount",     :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panel_deals", :force => true do |t|
    t.integer  "panel_plan_id"
    t.datetime "valid_until"
    t.integer  "deal_type"
    t.integer  "deal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["panel_plan_id"], :name => "index_panel_deals_on_panel_plan_id"
    t.foreign_key ["panel_plan_id"], "panel_plans", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_deals_ibfk_1"
  end

  create_table "panel_features", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panel_gateways", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.boolean  "status"
    t.string   "login"
    t.string   "password",   :limit => 125
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panel_organizations", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_panel_organizations_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_organizations_ibfk_1"
  end

  create_table "panel_organization_invitations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "panel_organization_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_panel_organization_invitations_on_user_id"
    t.index ["panel_organization_id"], :name => "index_panel_organization_invitations_on_panel_organization_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_organization_invitations_ibfk_1"
    t.foreign_key ["panel_organization_id"], "panel_organizations", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_organization_invitations_ibfk_2"
  end

  create_table "panel_organization_members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "panel_organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_panel_organization_members_on_user_id"
    t.index ["panel_organization_id"], :name => "index_panel_organization_members_on_panel_organization_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_organization_members_ibfk_1"
    t.foreign_key ["panel_organization_id"], "panel_organizations", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_organization_members_ibfk_2"
  end

  create_table "panel_planfeatures", :force => true do |t|
    t.integer  "panel_plan_id"
    t.integer  "panel_feature_id"
    t.integer  "up_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["panel_plan_id"], :name => "index_panel_planfeatures_on_panel_plan_id"
    t.index ["panel_feature_id"], :name => "index_panel_planfeatures_on_panel_feature_id"
    t.foreign_key ["panel_plan_id"], "panel_plans", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_planfeatures_ibfk_1"
    t.foreign_key ["panel_feature_id"], "panel_features", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_planfeatures_ibfk_2"
  end

  create_table "panel_subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "panel_plan_id"
    t.integer  "panel_deal_id"
    t.datetime "expired_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], :name => "index_panel_subscriptions_on_user_id"
    t.index ["panel_plan_id"], :name => "index_panel_subscriptions_on_panel_plan_id"
    t.index ["panel_deal_id"], :name => "index_panel_subscriptions_on_panel_deal_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_subscriptions_ibfk_1"
    t.foreign_key ["panel_plan_id"], "panel_plans", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_subscriptions_ibfk_2"
    t.foreign_key ["panel_deal_id"], "panel_deals", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_subscriptions_ibfk_3"
  end

  create_table "panel_subscription_transactions", :force => true do |t|
    t.integer  "panel_subscription_id"
    t.integer  "panel_gateway_id"
    t.decimal  "amount",                :precision => 10, :scale => 0
    t.boolean  "success"
    t.integer  "reference"
    t.string   "message"
    t.string   "action"
    t.string   "params"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["panel_subscription_id"], :name => "index_panel_subscription_transactions_on_panel_subscription_id"
    t.index ["panel_gateway_id"], :name => "index_panel_subscription_transactions_on_panel_gateway_id"
    t.foreign_key ["panel_subscription_id"], "panel_subscriptions", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_subscription_transactions_ibfk_1"
    t.foreign_key ["panel_gateway_id"], "panel_gateways", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "panel_subscription_transactions_ibfk_2"
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

  create_table "students", :force => true do |t|
    t.string   "email"
    t.string   "code"
    t.integer  "deleted"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["course_id"], :name => "index_students_on_course_id"
    t.foreign_key ["course_id"], "courses", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "students_ibfk_1"
  end

  create_table "solutions", :force => true do |t|
    t.integer  "question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "match_id",           :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "student_id"
    t.index ["question_id"], :name => "index_solutions_on_question_id"
    t.index ["match_id"], :name => "index_solutions_on_match_id"
    t.index ["student_id"], :name => "index_solutions_on_student_id"
    t.foreign_key ["student_id"], "students", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "solutions_ibfk_3"
    t.foreign_key ["question_id"], "questions", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "solutions_ibfk_1"
    t.foreign_key ["match_id"], "matches", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "solutions_ibfk_2"
  end

end
