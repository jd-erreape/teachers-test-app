# frozen_string_literal: true

class Teacher < ApplicationRecord
  has_secure_password

  include GivesVotes
  include ReceivesVotes

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :teacher_courses, dependent: :destroy
  has_many :courses, through: :teacher_courses
end
