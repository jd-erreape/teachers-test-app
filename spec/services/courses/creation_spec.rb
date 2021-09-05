# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Courses::Creation do
  subject(:created_course) { instance.run }

  let(:teacher) { create(:teacher) }
  let(:course_params) { { title: 'Course 1' } }
  let(:instance) { described_class.new(teacher: teacher, course_params: course_params) }

  RSpec.shared_examples 'returns an invalid course' do
    it 'returns a Course instance' do
      expect(created_course.class).to eq(Course)
    end

    it 'returns an invalid course' do
      expect(created_course).not_to be_valid
    end
  end

  context 'when the teacher provided is not provided' do
    let(:teacher) { nil }

    include_examples 'returns an invalid course'
  end

  context 'when the teacher provided is provided' do
    context 'when the course params are not valid' do
      let(:course_params) { {} }

      include_examples 'returns an invalid course'
    end

    context 'when the course params are valid' do
      it 'returns the new created course' do
        created_course_attributes = created_course
                                    .attributes
                                    .with_indifferent_access
                                    .values_at(*course_params.keys)

        expect(created_course_attributes).to eq(course_params.values)
      end

      it 'persists the new created course' do
        expect(created_course).to be_persisted
      end

      it 'registers the teacher within the course' do
        expect(TeacherCourse.where(teacher: teacher, course: created_course).length).to eq(1)
      end
    end
  end
end
