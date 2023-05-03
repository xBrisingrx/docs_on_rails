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

ActiveRecord::Schema.define(version: 2023_05_03_025256) do

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
    t.date "start_date"
    t.date "end_date"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "zone_job_profile_id"
    t.index ["assignated_type", "assignated_id"], name: "index_assignments_profiles_on_assignated_type_and_assignated_id"
    t.index ["zone_job_profile_id"], name: "index_assignments_profiles_on_zone_job_profile_id"
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clothes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clothes_packs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "clothe_id"
    t.bigint "clothing_package_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clothe_id"], name: "index_clothes_packs_on_clothe_id"
    t.index ["clothing_package_id"], name: "index_clothes_packs_on_clothing_package_id"
  end

  create_table "clothing_packages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "days_of_validity", default: 0, null: false
    t.boolean "expires", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "d_type", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cost_centers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "function_id"
    t.bigint "unit_business_id"
    t.string "descripcion"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["function_id"], name: "index_cost_centers_on_function_id"
    t.index ["unit_business_id"], name: "index_cost_centers_on_unit_business_id"
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
    t.integer "days_of_validity", default: 1
    t.integer "allow_modify_expiration", default: 0
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

  create_table "functions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geographic_zones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
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
    t.string "code", limit: 4
  end

  create_table "list_states_vehicles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
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

  create_table "people_clothes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "clothing_package_id"
    t.text "description", default: "''"
    t.date "start_date"
    t.date "end_date"
    t.boolean "active", default: true
    t.boolean "expires", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clothing_package_id"], name: "index_people_clothes_on_clothing_package_id"
    t.index ["person_id"], name: "index_people_clothes_on_person_id"
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
    t.string "code", limit: 4
  end

  create_table "reasons_to_disables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.integer "d_type", null: false
    t.string "reason", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_zones", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.bigint "geographic_zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geographic_zone_id"], name: "index_sub_zones_on_geographic_zone_id"
  end

  create_table "unit_businesses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "username", null: false
    t.string "email", null: false
    t.integer "rol", default: 2
    t.string "password_digest"
    t.boolean "active", default: true
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

  create_table "vehicle_insurances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "insurance_id"
    t.string "policy", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["insurance_id"], name: "index_vehicle_insurances_on_insurance_id"
    t.index ["vehicle_id"], name: "index_vehicle_insurances_on_vehicle_id"
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

  create_table "vehicle_states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "cost_center_id"
    t.bigint "sub_zone_id"
    t.bigint "operator_id"
    t.bigint "client_id"
    t.date "start_date"
    t.date "end_date"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "list_states_vehicle_id"
    t.index ["client_id"], name: "index_vehicle_states_on_client_id"
    t.index ["cost_center_id"], name: "index_vehicle_states_on_cost_center_id"
    t.index ["list_states_vehicle_id"], name: "index_vehicle_states_on_list_states_vehicle_id"
    t.index ["operator_id"], name: "index_vehicle_states_on_operator_id"
    t.index ["sub_zone_id"], name: "index_vehicle_states_on_sub_zone_id"
    t.index ["vehicle_id"], name: "index_vehicle_states_on_vehicle_id"
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

  create_table "zone_job_profile_docs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "zone_job_profile_id"
    t.bigint "document_id"
    t.date "start_date", comment: "Inicio vigencia de el documento en esta zona perfil trabajo"
    t.date "end_date", comment: "Fin vigencia de el documento en esta zona perfil trabajo"
    t.integer "d_type", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_zone_job_profile_docs_on_document_id"
    t.index ["zone_job_profile_id"], name: "index_zone_job_profile_docs_on_zone_job_profile_id"
  end

  create_table "zone_job_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "zone_id"
    t.bigint "job_id"
    t.bigint "profile_id"
    t.date "start_date", comment: "Inicio vigencia de el perfil en el trabajo"
    t.date "end_date", comment: "Fin vigencia de el perfil en el trabajo"
    t.integer "d_type", null: false
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
    t.string "code", limit: 4
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_histories", "reasons_to_disables"
  add_foreign_key "activity_histories", "users"
  add_foreign_key "assignments_documents", "documents"
  add_foreign_key "assignments_profiles", "zone_job_profiles"
  add_foreign_key "clothes_packs", "clothes"
  add_foreign_key "clothes_packs", "clothing_packages"
  add_foreign_key "cost_centers", "functions"
  add_foreign_key "cost_centers", "unit_businesses"
  add_foreign_key "document_renovations", "assignments_documents"
  add_foreign_key "documents", "document_categories"
  add_foreign_key "documents", "expiration_types"
  add_foreign_key "documents_profiles", "documents"
  add_foreign_key "documents_profiles", "profiles"
  add_foreign_key "people_clothes", "clothing_packages"
  add_foreign_key "people_clothes", "people"
  add_foreign_key "sub_zones", "geographic_zones"
  add_foreign_key "vehicle_insurances", "insurances"
  add_foreign_key "vehicle_insurances", "vehicles"
  add_foreign_key "vehicle_models", "vehicle_brands"
  add_foreign_key "vehicle_states", "clients"
  add_foreign_key "vehicle_states", "cost_centers"
  add_foreign_key "vehicle_states", "list_states_vehicles"
  add_foreign_key "vehicle_states", "operators"
  add_foreign_key "vehicle_states", "sub_zones"
  add_foreign_key "vehicle_states", "vehicles"
  add_foreign_key "vehicles", "companies"
  add_foreign_key "vehicles", "vehicle_locations"
  add_foreign_key "vehicles", "vehicle_models"
  add_foreign_key "vehicles", "vehicle_types"
  add_foreign_key "zone_job_profile_docs", "documents"
  add_foreign_key "zone_job_profile_docs", "zone_job_profiles"
  add_foreign_key "zone_job_profiles", "jobs"
  add_foreign_key "zone_job_profiles", "profiles"
  add_foreign_key "zone_job_profiles", "zones"
end
