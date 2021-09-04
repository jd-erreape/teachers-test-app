class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :title, index: { unique: true }

      t.timestamps
    end
  end
end
