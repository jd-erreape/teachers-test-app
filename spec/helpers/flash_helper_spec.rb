# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashHelper do
  describe '#flash_class' do
    subject { flash_class(flash_level) }

    context 'when flash_level is notice' do
      let(:flash_level) { 'notice' }

      it { is_expected.to eq(FlashHelper::SUCCESS_CLASS) }
    end

    context 'when flash_level is alert' do
      let(:flash_level) { 'alert' }

      it { is_expected.to eq(FlashHelper::ERROR_CLASS) }
    end

    context 'when flash_level is not recognized' do
      let(:flash_level) { 'unrecognized' }

      it { is_expected.to eq(FlashHelper::SUCCESS_CLASS) }
    end
  end
end
