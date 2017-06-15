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

ActiveRecord::Schema.define(version: 20170615120520) do

  create_table "ads", force: :cascade do |t|
    t.string   "region"
    t.string   "category"
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.string   "image"
    t.string   "city"
    t.integer  "userId"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_category"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cities", force: :cascade do |t|
    t.integer "ville_id"
    t.string  "ville_departement"
    t.string  "ville_slug"
    t.string  "ville_nom"
    t.string  "ville_nom_simple"
    t.string  "ville_nom_reel"
    t.string  "ville_nom_soundex"
    t.string  "ville_nom_metaphone"
    t.string  "ville_code_postal"
    t.string  "ville_commune"
    t.string  "ville_code_commune"
    t.integer "ville_arrondissement"
    t.string  "ville_canton"
    t.integer "ville_amdi"
    t.integer "ville_population_2010"
    t.integer "ville_population_1999"
    t.integer "ville_population_2012"
    t.integer "ville_densite_2010"
    t.float   "ville_surface"
    t.float   "ville_longitude_deg"
    t.float   "ville_latitude_deg"
    t.string  "ville_longitude_grd"
    t.string  "ville_latitude_grd"
    t.string  "ville_longitude_dms"
    t.string  "ville_latitude_dms"
    t.integer "ville_zmin"
    t.integer "ville_zmax"
  end

  add_index "cities", ["ville_id"], name: "index_cities_on_ville_id", unique: true

  create_table "departments", force: :cascade do |t|
    t.integer "departement_id"
    t.string  "departement_codes"
    t.string  "departement_nom"
    t.string  "departement_nom_uppercase"
    t.string  "departement_slug"
    t.string  "departement_nom_soundex"
  end

  add_index "departments", ["departement_id"], name: "index_departments_on_departement_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "pseudo",                 default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["pseudo"], name: "index_users_on_pseudo", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
