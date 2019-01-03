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

ActiveRecord::Schema.define(version: 2019_01_03_163505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.bigint "podcast_id"
    t.string "title"
    t.string "description"
    t.string "audioLink"
    t.string "audioType"
    t.string "audioLength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pubDate"
    t.datetime "pubDateParsed"
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "episode_id"
    t.integer "sort", default: 0
    t.boolean "played", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_playlists_on_episode_id"
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "podcast_genres", force: :cascade do |t|
    t.bigint "genre_id"
    t.bigint "podcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_podcast_genres_on_genre_id"
    t.index ["podcast_id"], name: "index_podcast_genres_on_podcast_id"
  end

  create_table "podcast_searches", force: :cascade do |t|
    t.bigint "podcast_id"
    t.bigint "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_podcast_searches_on_podcast_id"
    t.index ["search_id"], name: "index_podcast_searches_on_search_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "name"
    t.string "artistName"
    t.string "artistViewUrl"
    t.string "feedUrl"
    t.string "trackViewUrl"
    t.string "artworkUrl600"
    t.string "logo"
    t.string "description"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "search_term"
    t.integer "trackCount"
    t.string "slug", null: false
    t.index ["slug"], name: "index_podcasts_on_slug", unique: true
  end

  create_table "searches", force: :cascade do |t|
    t.string "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "podcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_subscriptions_on_podcast_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_id"
    t.string "username"
    t.string "password_digest"
  end

  add_foreign_key "episodes", "podcasts"
  add_foreign_key "playlists", "episodes"
  add_foreign_key "playlists", "users"
  add_foreign_key "podcast_genres", "genres"
  add_foreign_key "podcast_genres", "podcasts"
  add_foreign_key "podcast_searches", "podcasts"
  add_foreign_key "podcast_searches", "searches"
  add_foreign_key "subscriptions", "podcasts"
  add_foreign_key "subscriptions", "users"
end
