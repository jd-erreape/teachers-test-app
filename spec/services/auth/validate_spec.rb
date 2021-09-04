# frozen_string_literal: true

require 'rails_helper'

describe Auth::Validate do
  let(:password) { 'abc123' }
  let(:auth_password) { password }
  let(:teacher) { create(:teacher, password: password, password_confirmation: password) }
  let(:instance) { described_class.new(email: teacher.email, password: auth_password) }

  describe '#run' do
    subject { instance.run }

    context 'when the credentials are valid' do
      it { is_expected.to eq(teacher.id) }
    end

    context 'when the credentials are not valid' do
      let(:auth_password) { 'not_valid' }

      it { is_expected.to be_blank }
    end
  end
end
