# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotesHelper do
  describe '#votes_form_method' do
    subject { votes_form_method(already_voted) }

    context 'when it has been already voted' do
      let(:already_voted) { true }

      it { is_expected.to eq(:delete) }
    end

    context 'when it has not been already voted' do
      let(:already_voted) { false }

      it { is_expected.to eq(:post) }
    end
  end

  describe '#votes_button_message' do
    subject { votes_button_message(already_voted) }

    context 'when it has been already voted' do
      let(:already_voted) { true }

      it { is_expected.to eq(VotesHelper::REMOVE_VOTE_MESSAGE) }
    end

    context 'when it has not been already voted' do
      let(:already_voted) { false }

      it { is_expected.to eq(VotesHelper::VOTE_MESSAGE) }
    end
  end

  describe '#votes_button_class' do
    subject { votes_button_class(already_voted) }

    context 'when it has been already voted' do
      let(:already_voted) { true }

      it { is_expected.to eq(VotesHelper::REMOVE_VOTE_BUTTON_CLASS) }
    end

    context 'when it has not been already voted' do
      let(:already_voted) { false }

      it { is_expected.to eq(VotesHelper::VOTE_BUTTON_CLASS) }
    end
  end
end
