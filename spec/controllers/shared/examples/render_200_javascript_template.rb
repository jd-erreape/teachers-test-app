# frozen_string_literal: true

RSpec.shared_examples 'render 200 javascript template' do
  it 'returns a 200 status code' do
    expect(response.status).to eq(200)
  end

  it 'renders text/javascript content_type' do
    expect(response.content_type).to eq('text/javascript; charset=utf-8')
  end

  it 'renders the template' do
    expect(response).to render_template(template)
  end
end
