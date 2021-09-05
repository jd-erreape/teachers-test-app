# frozen_string_literal: true

require_relative './render_200_html_template'

RSpec.shared_examples 'index with resources' do |resource|
  let!(:resources) { 3.times.map { create(resource) } }

  def do_index
    get :index
  end

  before { do_index }

  include_examples 'render 200 html template' do
    let(:template) { 'index' }
  end

  it 'assigns the current courses' do
    expect(assigns[resource.to_s.pluralize]).to eq(resources)
  end
end
