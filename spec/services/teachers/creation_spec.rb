# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teachers::Creation do
  subject(:created_teacher) { instance.run }

  let(:context) { instance_double(ApplicationController) }
  let(:teacher_params) do
    build(:teacher).attributes.merge(
      password: 'password',
      password_confirmation: 'password'
    )
  end
  let(:instance) { described_class.new(context: context, teacher_params: teacher_params) }

  context 'when teacher params are not valid' do
    let(:teacher_params) { {} }

    it 'returns a teacher object' do
      expect(created_teacher.class).to eq(Teacher)
    end

    it 'does not persist the teacher' do
      expect(created_teacher).not_to be_persisted
    end
  end

  context 'when teacher params are valid' do
    before do
      allow(instance).to receive(:authenticate_teacher)
    end

    it 'returns a teacher object' do
      expect(created_teacher.class).to eq(Teacher)
    end

    it 'persists the teacher' do
      expect(created_teacher).to be_persisted
    end
  end
end
