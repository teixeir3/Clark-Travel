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

ActiveRecord::Schema.define(version: 20141218140400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_categories", force: true do |t|
    t.string   "title",       null: false
    t.integer  "position"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     null: false
  end

  add_index "booking_categories", ["user_id"], name: "index_booking_categories_on_user_id", using: :btree

  create_table "bookings", force: true do |t|
    t.string   "title",                                null: false
    t.string   "url",                                  null: false
    t.integer  "position"
    t.boolean  "display",              default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean  "carousel_display",     default: false, null: false
    t.integer  "category_id",                          null: false
  end

  add_index "bookings", ["carousel_display"], name: "index_bookings_on_carousel_display", using: :btree
  add_index "bookings", ["category_id"], name: "index_bookings_on_category_id", using: :btree
  add_index "bookings", ["display"], name: "index_bookings_on_display", using: :btree

  create_table "promotions", force: true do |t|
    t.string   "title",                                null: false
    t.integer  "user_id",                              null: false
    t.text     "highlight"
    t.text     "body"
    t.date     "start_date"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "position"
    t.boolean  "display",              default: true,  null: false
    t.boolean  "facebook_publish",     default: false, null: false
    t.boolean  "carousel_display",     default: false, null: false
  end

  add_index "promotions", ["carousel_display"], name: "index_promotions_on_carousel_display", using: :btree
  add_index "promotions", ["display"], name: "index_promotions_on_display", using: :btree
  add_index "promotions", ["facebook_publish"], name: "index_promotions_on_facebook_publish", using: :btree
  add_index "promotions", ["user_id"], name: "index_promotions_on_user_id", using: :btree

  create_table "testimonials", force: true do |t|
    t.string   "highlight"
    t.text     "body"
    t.integer  "user_id",                   null: false
    t.string   "signature",                 null: false
    t.boolean  "display",    default: true, null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "testimonials", ["display"], name: "index_testimonials_on_display", using: :btree
  add_index "testimonials", ["user_id"], name: "index_testimonials_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                       null: false
    t.string   "password_digest",                             null: false
    t.string   "session_token",                               null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.boolean  "is_admin",               default: false,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "is_active",              default: false,      null: false
    t.string   "activation_token",       default: "INACTIVE", null: false
    t.string   "uid"
    t.string   "access_token"
    t.string   "provider"
    t.integer  "position"
    t.string   "title"
    t.text     "bio"
    t.string   "work_phone"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "fax"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "fb_image_url"
    t.boolean  "display",                default: true,       null: false
  end

  add_index "users", ["display"], name: "index_users_on_display", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
