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

ActiveRecord::Schema.define(version: 20161122172243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.integer  "therapist_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "initial"
    t.datetime "birth_date"
    t.string   "phone"
    t.json     "emergency"
    t.integer  "wellness"
    t.string   "general_prac"
    t.string   "gender"
    t.string   "current_meds"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["therapist_id"], name: "index_clients_on_therapist_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "relation"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_contacts_on_client_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "event_type"
    t.date     "date"
    t.text     "description"
    t.boolean  "read",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["client_id"], name: "index_events_on_client_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "therapist_id"
    t.integer  "client_id"
    t.string   "title"
    t.text     "message"
    t.boolean  "shared"
    t.boolean  "read",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["client_id"], name: "index_notes_on_client_id", using: :btree
    t.index ["therapist_id"], name: "index_notes_on_therapist_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "client_id"
    t.boolean  "sharable",   default: true
    t.boolean  "read",       default: false
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["client_id"], name: "index_posts_on_client_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "client_id"
    t.boolean  "read",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "total"
    t.integer  "q1"
    t.integer  "q2"
    t.integer  "q3"
    t.integer  "q4"
    t.integer  "q5"
    t.integer  "q6"
    t.integer  "q7"
    t.integer  "q8"
    t.integer  "q9"
    t.index ["client_id"], name: "index_surveys_on_client_id", using: :btree
  end

  create_table "therapists", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cred"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "userable_id"
    t.string   "userable_type"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "clients", "therapists"
  add_foreign_key "contacts", "clients"
  add_foreign_key "events", "clients"
  add_foreign_key "notes", "clients"
  add_foreign_key "notes", "therapists"
  add_foreign_key "posts", "clients"
  add_foreign_key "surveys", "clients"
end
