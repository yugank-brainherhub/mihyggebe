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

ActiveRecord::Schema.define(version: 2020_11_02_081206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "assets", force: :cascade do |t|
    t.string "asset_type"
    t.string "assetable_type"
    t.bigint "assetable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort"
    t.string "name"
    t.index ["assetable_type", "assetable_id"], name: "index_assets_on_assetable_type_and_assetable_id"
  end

  create_table "bed_bookings", force: :cascade do |t|
    t.bigint "bed_id"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_id"], name: "index_bed_bookings_on_bed_id"
    t.index ["booking_id"], name: "index_bed_bookings_on_booking_id"
  end

  create_table "beds", force: :cascade do |t|
    t.string "bed_number"
    t.integer "bed_type"
    t.bigint "room_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_beds_on_room_id"
    t.index ["service_id"], name: "index_beds_on_service_id"
  end

  create_table "blacklist_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "checkin"
    t.datetime "checkout"
    t.datetime "arrival_time"
    t.integer "no_of_guests"
    t.boolean "doc_received"
    t.integer "status"
    t.bigint "care_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "mobile"
    t.integer "user_id"
    t.string "bookingID"
    t.text "price_includes"
    t.float "price_per_bed", default: 0.0
    t.datetime "cancelled_at"
    t.string "other_relation", default: [], array: true
    t.index ["care_id"], name: "index_bookings_on_care_id"
  end

  create_table "bookings_relationships", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "relationship_id"
    t.index ["booking_id"], name: "index_bookings_relationships_on_booking_id"
    t.index ["relationship_id"], name: "index_bookings_relationships_on_relationship_id"
  end

  create_table "care_details", force: :cascade do |t|
    t.text "description"
    t.text "area_description"
    t.integer "no_of_beds"
    t.integer "no_of_bathrooms"
    t.integer "no_of_restrooms"
    t.integer "no_of_rooms"
    t.bigint "care_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_id"], name: "index_care_details_on_care_id"
  end

  create_table "cares", force: :cascade do |t|
    t.text "address1"
    t.text "address2"
    t.text "address3"
    t.string "county"
    t.string "country"
    t.string "zipcode"
    t.string "state"
    t.string "fax_number"
    t.integer "category"
    t.integer "status"
    t.text "board_members"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "user_id"
    t.string "lat", default: ""
    t.string "lng", default: ""
    t.string "map_url", default: ""
    t.float "approx_distance", default: 0.0
    t.string "city"
    t.index ["user_id"], name: "index_cares_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "description"
    t.string "comment_type"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_comments_on_resource_type_and_resource_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.bigint "facility_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_type_id"], name: "index_facilities_on_facility_type_id"
    t.index ["name"], name: "index_facilities_on_name"
  end

  create_table "facility_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licences", force: :cascade do |t|
    t.integer "licence_type"
    t.bigint "care_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["care_id"], name: "index_licences_on_care_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.bigint "subscription_id"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_packages_on_plan_id"
    t.index ["subscription_id"], name: "index_packages_on_subscription_id"
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount"
    t.string "chargeId"
    t.text "description"
    t.integer "status"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
    t.index ["chargeId"], name: "index_payments_on_chargeId"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "plans", force: :cascade do |t|
    t.integer "min"
    t.integer "max"
    t.string "planId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price", default: 0.0
    t.integer "status", default: 0
  end

  create_table "refunds", force: :cascade do |t|
    t.float "amount", default: 0.0
    t.string "chargeId"
    t.string "refundId"
    t.text "description"
    t.integer "status"
    t.bigint "booking_id"
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_refunds_on_booking_id"
    t.index ["payment_id"], name: "index_refunds_on_payment_id"
    t.index ["refundId"], name: "index_refunds_on_refundId"
  end

  create_table "relationships", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_service_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_services", force: :cascade do |t|
    t.string "name"
    t.bigint "room_service_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_room_services_on_name"
    t.index ["room_service_type_id"], name: "index_room_services_on_room_service_type_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "room_type"
    t.integer "bathroom_type"
    t.float "price"
    t.datetime "available_from"
    t.datetime "available_to"
    t.text "price_desc"
    t.bigint "care_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "beds_count", default: 0
    t.index ["care_id"], name: "index_rooms_on_care_id"
  end

  create_table "selected_facilities", force: :cascade do |t|
    t.bigint "care_id"
    t.bigint "facility_id"
    t.bigint "facility_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_id"], name: "index_selected_facilities_on_care_id"
    t.index ["facility_id"], name: "index_selected_facilities_on_facility_id"
    t.index ["facility_type_id"], name: "index_selected_facilities_on_facility_type_id"
  end

  create_table "selected_room_services", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "room_service_id"
    t.bigint "room_service_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_selected_room_services_on_room_id"
    t.index ["room_service_id"], name: "index_selected_room_services_on_room_service_id"
    t.index ["room_service_type_id"], name: "index_selected_room_services_on_room_service_type_id"
  end

  create_table "selected_rooms", force: :cascade do |t|
    t.bigint "care_id"
    t.bigint "room_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_id"], name: "index_selected_rooms_on_care_id"
    t.index ["room_type_id"], name: "index_selected_rooms_on_room_type_id"
  end

  create_table "selected_services", force: :cascade do |t|
    t.bigint "care_id"
    t.bigint "service_id"
    t.bigint "service_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_id"], name: "index_selected_services_on_care_id"
    t.index ["service_id"], name: "index_selected_services_on_service_id"
    t.index ["service_type_id"], name: "index_selected_services_on_service_type_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "available_for"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.bigint "service_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "desc"
    t.index ["name"], name: "index_services_on_name"
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
  end

  create_table "staff_details", force: :cascade do |t|
    t.string "name"
    t.bigint "care_id"
    t.bigint "staff_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_id"], name: "index_staff_details_on_care_id"
    t.index ["staff_role_id"], name: "index_staff_details_on_staff_role_id"
  end

  create_table "staff_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_refunds", force: :cascade do |t|
    t.bigint "subscription_id"
    t.string "refundId"
    t.string "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_subscription_refunds_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "subscriptionId"
    t.string "planId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "care_id"
    t.string "payment_intent"
    t.datetime "subscribed_at"
    t.integer "status"
    t.index ["care_id"], name: "index_subscriptions_on_care_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.float "provider_amount"
    t.float "mih_commission_amt"
    t.string "transferId"
    t.integer "status"
    t.bigint "booking_id"
    t.bigint "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_transfers_on_booking_id"
    t.index ["payment_id"], name: "index_transfers_on_payment_id"
    t.index ["transferId"], name: "index_transfers_on_transferId"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.bigint "role_id"
    t.string "mobile"
    t.string "messenger"
    t.string "stripeID"
    t.boolean "above18"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "organization"
    t.text "address"
    t.string "profession"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.string "docusign_status"
    t.integer "status"
    t.date "checker_paid_date"
    t.date "checker_future_payment"
    t.integer "checkr_status", default: 0
    t.boolean "first_time", default: true
    t.boolean "email_sent", default: false
    t.string "accountId"
    t.string "checkrId"
    t.string "invitation_status", default: ""
    t.boolean "bank_details", default: false
    t.boolean "payouts_enabled", default: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "care_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_id"], name: "index_wishlists_on_care_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cares", "users"
  add_foreign_key "packages", "plans"
  add_foreign_key "packages", "subscriptions"
  add_foreign_key "subscriptions", "cares"
end
