# frozen_string_literal: true

RSpec.shared_examples 'gives votes' do
  it { is_expected.to have_many(:votes_given).dependent(:destroy) }

  describe '#voted_for?' do
    subject { instance.voted_for?(voted) }

    let(:instance) { create(described_class.name.underscore, votes_given: [create(:vote)]) }

    context 'when there is a vote for the given element' do
      let(:voted) { instance.votes_given.first.voted }

      it { is_expected.to be_truthy }
    end

    context 'when there is not a vote for the given element' do
      let(:voted) { build(:vote).voted }

      it { is_expected.to be_falsey }
    end
  end
end
