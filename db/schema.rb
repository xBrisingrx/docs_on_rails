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

ActiveRecord::Schema.define(version: 2023_02_03_200553) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activity_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "record_type"
    t.bigint "record_id"
    t.integer "action", null: false
    t.text "description"
    t.date "date"
    t.bigint "reasons_to_disable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reasons_to_disable_id"], name: "index_activity_histories_on_reasons_to_disable_id"
    t.index ["record_type", "record_id"], name: "index_activity_histories_on_record_type_and_record_id"
    t.index ["user_id"], name: "index_activity_histories_on_user_id"
  end

  create_table "assignments_documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "assignated_type"
    t.bigint "assignated_id"
    t.bigint "document_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "custom", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignated_type", "assignated_id"], name: "index_assignments_documents_on_assignated_type_and_assignated_id"
    t.index ["document_id"], name: "index_assignments_documents_on_document_id"
  end

  create_table "assignments_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "assignated_type"
    t.bigint "assignated_id"
    t.bigint "profile_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignated_type", "assignated_id"], name: "index_assignments_profiles_on_assignated_type_and_assignated_id"
    t.index ["profile_id"], name: "index_assignments_profiles_on_profile_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "d_type", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_renovations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "assignments_document_id"
    t.date "renovation_date"
    t.date "expiration_date"
    t.boolean "active", default: true
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignments_document_id"], name: "index_document_renovations_on_assignments_document_id"
  end

  create_table "documents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "d_type", null: false
    t.string "name", null: false
    t.string "description"
    t.boolean "expires", default: false
    t.integer "days_of_validity"
    t.boolean "allow_modify_expiration"
    t.text "observations"
    t.text "renewal_methodology"
    t.boolean "monthly_summary", default: true
    t.date "start_date", comment: "Desde cuando se empezo a usar este documento"
    t.date "end_date", comment: "Hasta cuando se uso este documento"
    t.boolean "active", default: true
    t.bigint "document_category_id"
    t.bigint "expiration_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_category_id"], name: "index_documents_on_document_category_id"
    t.index ["expiration_type_id"], name: "index_documents_on_expiration_type_id"
  end

  create_table "documents_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "d_type", null: false
    t.bigint "profile_id"
    t.bigint "document_id"
    t.date "start_date", comment: "Desde cuando se empezo a usar este documento en este perfil"
    t.date "end_date", comment: "Hasta cuando se uso este documento en este perfil"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_documents_profiles_on_document_id"
    t.index ["profile_id"], name: "index_documents_profiles_on_profile_id"
  end

  create_table "expiration_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.integer "days"
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "d_type", null: false
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "file", null: false, comment: "Legajo de la persona"
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "dni"
    t.integer "tramit_number"
    t.string "cuil"
    t.string "email"
    t.boolean "dni_has_expiration"
    t.date "expiration_dni_date"
    t.date "birth_date"
    t.string "nationality"
    t.string "direction"
    t.string "phone"
    t.date "start_activity"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "d_type"
    t.string "name", null: false
    t.date "start_date", comment: "Desde cuando se empezo a usar este perfil"
    t.date "end_date", comment: "Hasta cuando se uso perfil"
    t.string "description"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reasons_to_disables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "d_type", null: false
    t.string "reason", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.integer "rol"
    t.string "password_digest"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_models", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.bigint "vehicle_brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_brand_id"], name: "index_vehicle_models_on_vehicle_brand_id"
  end

  create_table "vehicle_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "domain"
    t.string "chassis"
    t.string "engine"
    t.string "seats"
    t.integer "year"
    t.text "observations"
    t.boolean "active", default: true
    t.bigint "vehicle_type_id"
    t.bigint "vehicle_model_id"
    t.bigint "vehicle_location_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_vehicles_on_company_id"
    t.index ["vehicle_location_id"], name: "index_vehicles_on_vehicle_location_id"
    t.index ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

  create_table "zone_job_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "zone_id"
    t.bigint "job_id"
    t.bigint "profile_id"
    t.date "start_date", comment: "Inicio vigencia de el perfil en el trabajo"
    t.date "end_date", comment: "Fin vigencia de el perfil en el trabajo"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_zone_job_profiles_on_job_id"
    t.index ["profile_id"], name: "index_zone_job_profiles_on_profile_id"
    t.index ["zone_id"], name: "index_zone_job_profiles_on_zone_id"
  end

  create_table "zones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_histories", "reasons_to_disables"
  add_foreign_key "activity_histories", "users"
  add_foreign_key "assignments_documents", "documents"
  add_foreign_key "assignments_profiles", "profiles"
  add_foreign_key "document_renovations", "assignments_documents"
  add_foreign_key "documents", "document_categories"
  add_foreign_key "documents", "expiration_types"
  add_foreign_key "documents_profiles", "documents"
  add_foreign_key "documents_profiles", "profiles"
  add_foreign_key "vehicle_models", "vehicle_brands"
  add_foreign_key "vehicles", "companies"
  add_foreign_key "vehicles", "vehicle_locations"
  add_foreign_key "vehicles", "vehicle_models"
  add_foreign_key "vehicles", "vehicle_types"
  add_foreign_key "zone_job_profiles", "jobs"
  add_foreign_key "zone_job_profiles", "profiles"
  add_foreign_key "zone_job_profiles", "zones"
end
