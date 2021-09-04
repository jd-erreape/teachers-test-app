# frozen_string_literal: true

class TeacherCourse < ApplicationRecord
  validates :teacher, presence: true, uniqueness: { scope: :course }
  validates :course, presence: true

  belongs_to :teacher
  belongs_to :course
end
