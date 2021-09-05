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

ActiveRecord::Schema.define(version: 2021_09_05_085224) do

  create_table "courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_courses_on_title", unique: true
  end

  create_table "teacher_courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_teacher_courses_on_course_id"
    t.index ["teacher_id", "course_id"], name: "index_teacher_courses_on_teacher_id_and_course_id", unique: true
    t.index ["teacher_id"], name: "index_teacher_courses_on_teacher_id"
  end

  create_table "teachers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
  end

  create_table "votes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "voted_type", null: false
    t.bigint "voted_id", null: false
    t.string "voter_type", null: false
    t.bigint "voter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["voted_id", "voted_type", "voter_id"], name: "index_votes_on_voted_id_and_voted_type_and_voter_id", unique: true
    t.index ["voted_type", "voted_id"], name: "index_votes_on_voted"
    t.index ["voter_id", "voter_type", "voted_id"], name: "index_votes_on_voter_id_and_voter_type_and_voted_id", unique: true
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter"
  end

  add_foreign_key "teacher_courses", "courses"
  add_foreign_key "teacher_courses", "teachers"
end
