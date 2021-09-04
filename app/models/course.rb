# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :teacher_courses, dependent: :destroy
  has_many :teachers, through: :teacher_courses

  def imparted_by?(teacher)
    teachers.include?(teacher)
  end
end
