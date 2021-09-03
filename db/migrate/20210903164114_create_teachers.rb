class CreateTeachers < ActiveRecord::Migration[6.1]
  def change
    create_table :teachers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
