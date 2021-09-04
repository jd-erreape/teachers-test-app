# frozen_string_literal: true

RSpec.shared_examples 'render 200 html template' do
  it 'returns a 200 status code' do
    expect(response.status).to eq(200)
  end

  it 'returns text/html content' do
    expect(response.content_type).to eq('text/html; charset=utf-8')
  end

  it 'renders new template' do
    expect(response).to render_template(template)
  end
end
