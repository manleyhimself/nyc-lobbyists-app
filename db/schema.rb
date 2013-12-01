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

ActiveRecord::Schema.define(version: 20131201002744) do

  create_table "actions", force: true do |t|
    t.string   "purpose"
    t.integer  "lobbyist_id"
    t.integer  "client_id"
    t.integer  "agency_id"
    t.boolean  "admin"
    t.boolean  "legislative"
    t.integer  "payment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "all_payments"
  end

  create_table "firms", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "all_payments"
  end

  create_table "lobbyists", force: true do |t|
    t.string   "name"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "all_payments"
  end

end
