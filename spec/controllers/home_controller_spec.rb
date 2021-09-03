require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    def do_index
      get :index
    end

    before { do_index }

    it 'returns a 200 status code with text/html content' do
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end
end