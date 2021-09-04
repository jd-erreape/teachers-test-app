class CreateTeacherCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :teacher_courses do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :teacher_courses, [:teacher_id, :course_id], unique: true
  end
end
