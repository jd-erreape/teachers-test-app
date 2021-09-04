# frozen_string_literal: true

RSpec.shared_examples 'not authorized' do
  it 'redirects to root page' do
    expect(response).to redirect_to(root_path)
  end

  it 'sets proper flash message' do
    expect(response.request.flash[:alert]).to eq(ApplicationController::NOT_AUTHORIZED_MESSAGE)
  end
end
