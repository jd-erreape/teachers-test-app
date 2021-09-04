# frozen_string_literal: true

require 'rails_helper'

describe Auth::LogIn do
  let(:context) { instance_double(ApplicationController) }
  let(:email) { 'test@test.com' }
  let(:password) { 'abc123' }
  let(:teacher_id) { 1 }
  let(:validate_service) { instance_double(Auth::Validate, run: validate_result) }
  let(:create_service) { instance_double(Auth::Create, run: true) }
  let(:instance) { described_class.new(context: context, email: email, password: password) }

  describe '#run' do
    subject { instance.run }

    before do
      allow(Auth::Validate)
        .to receive(:new)
          .with(
            email: email,
            password: password
          ) { validate_service }
    end

    context 'when the credentials validation does not succeed' do
      let(:validate_result) { false }

      it { is_expected.to be_falsey }
    end

    context 'when the credentials validation succeeds' do
      let(:validate_result) { teacher_id }

      before do
        allow(Auth::Create)
          .to receive(:new)
            .with(
              context: context,
              teacher_id: teacher_id
            ) { create_service }

        expect(create_service).to receive(:run)
      end

      it { is_expected.to be_truthy }
    end
  end
end
