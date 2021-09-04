# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#disable_status' do
    subject { disable_status(current_teacher) }

    context 'when current_teacher is provided' do
      let(:current_teacher) { double }

      it { is_expected.to eq('') }
    end

    context 'when current_teacher is not provided' do
      let(:current_teacher) { nil }

      it { is_expected.to eq(ApplicationHelper::DISABLED_CLASS) }
    end
  end
end
