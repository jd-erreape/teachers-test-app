# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { is_expected.to validate_presence_of(:voter) }
  it { is_expected.to validate_presence_of(:voted) }
  it { is_expected.to belong_to(:voter) }
  it { is_expected.to belong_to(:voted) }

  describe 'validate uniqueness of voted scoped to voter' do
    subject { other_vote.errors[:voted_id] }

    let(:vote) { create(:vote, :for_teacher) }
    let(:other_vote) { build(:vote, voted: voted, voter: vote.voter) }

    before { other_vote.valid? }

    context 'when the voter has already a vote for the voted' do
      let(:voted) { vote.voted }

      it { is_expected.not_to be_empty }
    end

    context 'when the voter does not have already a vote for the voted' do
      let(:voted) { build(:teacher) }

      it { is_expected.to be_empty }
    end
  end
end
