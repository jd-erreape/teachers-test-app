# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  it { is_expected.to have_many(:teacher_courses).dependent(:destroy) }
  it { is_expected.to have_many(:teachers).through(:teacher_courses) }

  describe '#imparted_by?' do
    subject { course.imparted_by?(given_teacher) }

    let(:teacher) { build(:teacher) }
    let(:course) { build(:course, teachers: [teacher]) }

    context 'when the course is imparted by the given teacher' do
      let(:given_teacher) { teacher }

      it { is_expected.to be_truthy }
    end

    context 'when the course is not imparted by the given teacher' do
      let(:given_teacher) { build(:teacher) }

      it { is_expected.to be_falsey }
    end
  end
end
