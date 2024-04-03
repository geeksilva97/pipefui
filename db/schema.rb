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

ActiveRecord::Schema[7.1].define(version: 2024_04_02_165612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_values", force: :cascade do |t|
    t.string "field_name"
    t.string "field_value"
    t.bigint "answer_id", null: false
    t.uuid "field_id", null: false
    t.bigint "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_values_on_answer_id"
    t.index ["field_id"], name: "index_answer_values_on_field_id"
    t.index ["form_id"], name: "index_answer_values_on_form_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string "preview"
    t.bigint "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_answers_on_form_id"
  end

  create_table "fields", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "field_type"
    t.boolean "is_required", default: false
    t.bigint "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_fields_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "title"
    t.boolean "can_answer", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answer_values", "answers", on_delete: :cascade
  add_foreign_key "answer_values", "fields", on_delete: :nullify
  add_foreign_key "answer_values", "forms", on_delete: :cascade
  add_foreign_key "answers", "forms", on_delete: :cascade
  add_foreign_key "fields", "forms", on_delete: :cascade
end
