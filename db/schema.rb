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

ActiveRecord::Schema.define(version: 2021_03_04_171618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.string "jti", null: false
    t.string "aud"
    t.datetime "exp", null: false
    t.bigint "user_id", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "movie_ratings", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id", "user_id"], name: "index_movie_ratings_on_movie_id_and_user_id", unique: true
    t.index ["movie_id"], name: "index_movie_ratings_on_movie_id"
    t.index ["user_id"], name: "index_movie_ratings_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "omdb_id"
    t.integer "omdb_fetch_status"
    t.string "omdb_fetch_error"
    t.float "price"
    t.string "name"
    t.string "description"
    t.string "release_date"
    t.string "imdb_rating"
    t.string "runtime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "overall_ratings_sum"
    t.integer "overall_ratings_count"
    t.index ["omdb_id"], name: "index_movies_on_omdb_id", unique: true
  end

  create_table "show_times", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_show_times_on_movie_id"
    t.index ["start_time"], name: "index_show_times_on_start_time"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "is_cinema_worker", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "movie_ratings", "movies"
  add_foreign_key "movie_ratings", "users"
  add_foreign_key "show_times", "movies"
end
