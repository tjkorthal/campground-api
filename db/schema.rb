# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_07_231840) do

  create_table "booked_days", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "booking_id"
    t.index ["booking_id"], name: "index_booked_days_on_booking_id"
    t.index ["date", "booking_id"], name: "unique_date_per_booking", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "campsite_id"
    t.index ["campsite_id"], name: "index_bookings_on_campsite_id"
  end

  create_table "campgrounds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "unique_campground_name", unique: true
  end

  create_table "campsites", force: :cascade do |t|
    t.string "name", null: false
    t.float "price_usd", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "campground_id"
    t.index ["campground_id"], name: "index_campsites_on_campground_id"
    t.index ["name", "campground_id"], name: "unique_campsite_name", unique: true
  end

end
