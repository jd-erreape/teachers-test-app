# frozen_string_literal: true

RSpec.shared_context 'with current teacher' do
  let(:current_teacher) { create(:teacher) }

  before { allow(controller).to receive(:current_teacher) { current_teacher } }
end
