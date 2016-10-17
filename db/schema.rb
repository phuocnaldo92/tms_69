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

ActiveRecord::Schema.define(version: 20161017124556) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",     limit: 65535
    t.boolean  "is_correct"
    t.integer  "Question_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["Question_id"], name: "index_answers_on_Question_id", using: :btree
  end

  create_table "exam_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",          limit: 65535
    t.boolean  "is_choice"
    t.integer  "Exam_question_id"
    t.integer  "Answer_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["Answer_id"], name: "index_exam_answers_on_Answer_id", using: :btree
    t.index ["Exam_question_id"], name: "index_exam_answers_on_Exam_question_id", using: :btree
  end

  create_table "exam_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",     limit: 65535
    t.boolean  "is_correct"
    t.integer  "Exam_id"
    t.integer  "Question_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["Exam_id"], name: "index_exam_questions_on_Exam_id", using: :btree
    t.index ["Question_id"], name: "index_exam_questions_on_Question_id", using: :btree
  end

  create_table "exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "status"
    t.datetime "started_at"
    t.integer  "spent_time"
    t.integer  "score"
    t.integer  "User_id"
    t.integer  "Subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Subject_id"], name: "index_exams_on_Subject_id", using: :btree
    t.index ["User_id"], name: "index_exams_on_User_id", using: :btree
  end

  create_table "levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "question_number"
    t.integer  "Subject_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["Subject_id"], name: "index_levels_on_Subject_id", using: :btree
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "type"
    t.text     "content",    limit: 65535
    t.integer  "Level_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["Level_id"], name: "index_questions_on_Level_id", using: :btree
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "question_number"
    t.integer  "duration"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "suggest_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",             limit: 65535
    t.boolean  "is_correct"
    t.integer  "Suggest_question_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["Suggest_question_id"], name: "index_suggest_answers_on_Suggest_question_id", using: :btree
  end

  create_table "suggest_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "status"
    t.integer  "type"
    t.text     "content",    limit: 65535
    t.integer  "User_id"
    t.integer  "Subject_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["Subject_id"], name: "index_suggest_questions_on_Subject_id", using: :btree
    t.index ["User_id"], name: "index_suggest_questions_on_User_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "chatwork_id"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "role"
    t.string   "avatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "answers", "Questions"
  add_foreign_key "exam_answers", "Answers"
  add_foreign_key "exam_answers", "Exam_questions"
  add_foreign_key "exam_questions", "Exams"
  add_foreign_key "exam_questions", "Questions"
  add_foreign_key "exams", "Subjects"
  add_foreign_key "exams", "Users"
  add_foreign_key "levels", "Subjects"
  add_foreign_key "questions", "Levels"
  add_foreign_key "suggest_answers", "Suggest_questions"
  add_foreign_key "suggest_questions", "Subjects"
  add_foreign_key "suggest_questions", "Users"
end
