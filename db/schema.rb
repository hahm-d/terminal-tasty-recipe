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

ActiveRecord::Schema.define(version: 2020_07_08_194959) do

  create_table "dish_searches", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "user_id"
    t.integer "user_like"
  end

  create_table "instructions", force: :cascade do |t|
    t.text "step"
    t.integer "recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.integer "tasty_remote_id"
    t.integer "calories"
    t.text "description"
    t.integer "total_time"
    t.integer "num_serving"
    t.text "keywords"
  end

  create_table "search_histories", force: :cascade do |t|
    t.string "s_text"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "f_name"
    t.string "l_name"
    t.date "dob"
    t.string "f_food"
    t.string "username"
    t.string "password"
  end

end
