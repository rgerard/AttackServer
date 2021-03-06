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

ActiveRecord::Schema.define(:version => 20110613060441) do

  create_table "attacks", :force => true do |t|
    t.string   "attack_name"
    t.string   "attack_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_attacks", :force => true do |t|
    t.integer  "attacker_id"
    t.integer  "victim_id"
    t.integer  "attack_id"
    t.string   "message"
    t.datetime "created_at"
    t.boolean  "action_taken"
    t.boolean  "email_sent"
    t.boolean  "push_sent"
    t.datetime "updated_at"
    t.string   "id_hash"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "appUser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fbid"
    t.string   "device_token"
  end

end
