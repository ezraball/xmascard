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

ActiveRecord::Schema.define(:version => 20130223130803) do

  create_table "cards", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.text     "message"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "frontimg_file_name"
    t.string   "frontimg_content_type"
    t.integer  "frontimg_file_size"
    t.datetime "frontimg_updated_at"
    t.string   "backimg_file_name"
    t.string   "backimg_content_type"
    t.integer  "backimg_file_size"
    t.datetime "backimg_updated_at"
  end

end
