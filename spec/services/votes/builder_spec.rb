# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Votes::Builder do
  subject(:built_vote) { instance.run }

  let(:voter) { build(:teacher) }
  let(:voted) { build(:course) }
  let(:instance) { described_class.new(voter: voter, voted: voted) }

  describe '#run' do
    context 'when there is no voted' do
      let(:voted) { nil }

      it 'raises a VotedNotDefined error' do
        expect { built_vote }.to raise_error(Votes::Builder::VotedNotDefined)
      end
    end

    context 'when there is no voter' do
      let(:voter) { nil }

      it 'returns a vote object' do
        expect(built_vote.class).to eq(Vote)
      end

      it 'returns a not persisted object' do
        expect(built_vote).not_to be_persisted
      end

      it 'assigns the voter as nil' do
        expect(built_vote.voter).to be_blank
      end

      it 'assigns the voted' do
        expect(built_vote.voted).to eq(voted)
      end
    end

    context 'when there is a voter and a voted' do
      context 'when the voter has not voted for the vote voted' do
        it 'returns a vote object' do
          expect(built_vote.class).to eq(Vote)
        end

        it 'returns a not persisted object' do
          expect(built_vote).not_to be_persisted
        end

        it 'assigns the voter' do
          expect(built_vote.voter).to eq(voter)
        end

        it 'assigns the voted' do
          expect(built_vote.voted).to eq(voted)
        end
      end

      context 'when the voter has voted for the vote voted' do
        let!(:vote) { create(:vote, voter: voter, voted: voted) }

        it { is_expected.to eq(vote) }
      end
    end
  end
end
