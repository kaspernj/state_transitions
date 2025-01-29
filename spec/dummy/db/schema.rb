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

ActiveRecord::Schema[7.2].define(version: 2025_01_29_124207) do
  create_table "state_transitions", force: :cascade do |t|
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.string "user_type"
    t.integer "user_id"
    t.string "state_from", null: false
    t.string "state_to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_state_transitions_on_resource"
    t.index ["user_type", "user_id"], name: "index_state_transitions_on_user"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", default: "new", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
