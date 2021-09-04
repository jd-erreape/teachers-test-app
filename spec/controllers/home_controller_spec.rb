# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/examples/render_200_html_template'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    def do_index
      get :index
    end

    before { do_index }

    include_examples 'render 200 html template' do
      let(:template) { 'index' }
    end
  end
end
