# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_16_142108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "advertisements", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_advertisements_on_composite_type_and_composite_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "reference"
    t.string "attachable_type", null: false
    t.bigint "attachable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
  end

  create_table "companies", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name"
    t.text "description_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "phone"
    t.boolean "enabled", default: false
    t.string "chatra_id"
    t.text "web_address"
    t.text "sales_email"
    t.text "tel"
    t.text "sales_person_name"
    t.text "address"
    t.boolean "featured"
    t.string "meeting_link"
    t.string "fullname"
    t.index ["event_id"], name: "index_companies_on_event_id"
  end

  create_table "company_exhibitors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_exhibitors_on_company_id"
    t.index ["user_id", "company_id"], name: "index_company_exhibitors_on_user_id_and_company_id", unique: true
    t.index ["user_id"], name: "index_company_exhibitors_on_user_id"
  end

  create_table "company_presenters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_presenters_on_company_id"
    t.index ["user_id", "company_id"], name: "index_company_presenters_on_user_id_and_company_id", unique: true
    t.index ["user_id"], name: "index_company_presenters_on_user_id"
  end

  create_table "event_admins", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["event_id"], name: "index_event_admins_on_event_id"
    t.index ["user_id"], name: "index_event_admins_on_user_id"
  end

  create_table "event_attendees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_attendees_on_event_id"
    t.index ["user_id", "event_id"], name: "index_event_attendees_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_event_attendees_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "phone"
    t.text "banner_text_short"
    t.boolean "show_featured_companies"
    t.string "meeting_link"
    t.string "chatra_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "information_blocks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_information_blocks_on_composite_type_and_composite_id"
  end

  create_table "mail_settings", force: :cascade do |t|
    t.string "email"
    t.string "address"
    t.string "password"
    t.string "port"
    t.boolean "starttls_auto", default: true
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_mail_settings_on_composite_type_and_composite_id"
  end

  create_table "page_items", force: :cascade do |t|
    t.string "title"
    t.string "title_secondary"
    t.text "description"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_page_items_on_composite_type_and_composite_id"
  end

  create_table "presentation_presenters", force: :cascade do |t|
    t.bigint "company_exhibitor_id", null: false
    t.bigint "presentation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_exhibitor_id"], name: "index_presentation_presenters_on_company_exhibitor_id"
    t.index ["presentation_id"], name: "index_presentation_presenters_on_presentation_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "title"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "description"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "name"
    t.text "surname"
    t.string "presentation_type"
    t.index ["event_id"], name: "index_presentations_on_event_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "value"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.index ["composite_type", "composite_id"], name: "index_ratings_on_composite_type_and_composite_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "site_admins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_site_admins_on_user_id"
  end

  create_table "socials", force: :cascade do |t|
    t.string "facebook_url"
    t.string "instagram_url"
    t.string "twitter_url"
    t.string "linkedin_url"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_socials_on_composite_type_and_composite_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_sponsors_on_event_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_description_selects", force: :cascade do |t|
    t.string "value"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_user_description_selects_on_composite_columns"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "country"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "language"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "path"
    t.string "title"
    t.text "description"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "video_type"
    t.index ["composite_type", "composite_id"], name: "index_videos_on_composite_type_and_composite_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name"
    t.string "title"
    t.text "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "zoom_user_id"
    t.string "facilitator"
    t.index ["event_id"], name: "index_workshops_on_event_id"
    t.index ["zoom_user_id"], name: "index_workshops_on_zoom_user_id"
  end

  create_table "zoom_configs", force: :cascade do |t|
    t.string "join_url"
    t.string "host_id"
    t.string "meeting_id"
    t.string "start_url"
    t.string "composite_type", null: false
    t.bigint "composite_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["composite_type", "composite_id"], name: "index_zoom_configs_on_composite_type_and_composite_id"
  end

  create_table "zoom_users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.integer "user_type"
    t.string "zoom_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companies", "events"
  add_foreign_key "company_exhibitors", "companies"
  add_foreign_key "company_exhibitors", "users"
  add_foreign_key "company_presenters", "companies"
  add_foreign_key "company_presenters", "users"
  add_foreign_key "event_admins", "events"
  add_foreign_key "event_admins", "users"
  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "users"
  add_foreign_key "presentation_presenters", "company_exhibitors"
  add_foreign_key "presentation_presenters", "presentations"
  add_foreign_key "presentations", "events"
  add_foreign_key "ratings", "users"
  add_foreign_key "site_admins", "users"
  add_foreign_key "sponsors", "events"
  add_foreign_key "taggings", "tags"
  add_foreign_key "workshops", "events"
  add_foreign_key "workshops", "zoom_users"
end
