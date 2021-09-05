# frozen_string_literal: true

RSpec.shared_examples 'receives votes' do
  it { is_expected.to have_many(:votes_received).dependent(:destroy) }
end
