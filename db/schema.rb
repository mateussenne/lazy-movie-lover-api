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

ActiveRecord::Schema.define(version: 2023_11_01_153623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_movies", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_favorite_movies_on_movie_id"
    t.index ["user_id"], name: "index_favorite_movies_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "poster_image"
    t.string "url"
    t.bigint "stream_service_id", null: false
    t.string "synopsis"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_movies_on_slug", unique: true
    t.index ["stream_service_id"], name: "index_movies_on_stream_service_id"
  end

  create_table "scrape_errors", force: :cascade do |t|
    t.string "error", null: false
    t.bigint "stream_service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stream_service_id"], name: "index_scrape_errors_on_stream_service_id"
  end

  create_table "stream_services", force: :cascade do |t|
    t.string "name"
    t.string "base_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.integer "age"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "favorite_movies", "movies"
  add_foreign_key "favorite_movies", "users"
  add_foreign_key "movies", "stream_services"
  add_foreign_key "scrape_errors", "stream_services"
end
