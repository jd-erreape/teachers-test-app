# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeacherCourse, type: :model do
  it { is_expected.to validate_presence_of(:teacher) }
  it { is_expected.to validate_presence_of(:course) }
  it { is_expected.to belong_to(:teacher) }
  it { is_expected.to belong_to(:course) }

  # We are testing the scoped uniqueness manually and not with
  # shoulda matchers because there is a bug when the DB fields
  # are set as not NULL, more info can be seen in
  # https://github.com/thoughtbot/shoulda-matchers/issues/194
  describe 'validate uniqueness of teacher scoped to course' do
    subject { other_teacher_course.errors[:teacher] }

    let(:teacher_course) { create(:teacher_course) }
    let(:other_teacher_course) { build(:teacher_course, teacher: teacher_course.teacher, course: course) }

    before { other_teacher_course.valid? }

    context 'when the course has been taken by the teacher' do
      let(:course) { teacher_course.course }

      it { is_expected.not_to be_empty }
    end

    context 'when the course has not been taken by the teacher' do
      let(:course) { build(:course) }

      it { is_expected.to be_empty }
    end
  end
end
