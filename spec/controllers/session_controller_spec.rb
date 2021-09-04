# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/contexts/current_teacher'
require_relative './shared/examples/render_200_html_template'
require_relative './shared/examples/not_authorized'

RSpec.describe SessionController, type: :controller do
  describe '#new' do
    def do_new
      get :new
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_new }

      include_examples 'not authorized'
    end

    context 'when the teacher is not authorized' do
      before { do_new }

      include_examples 'render 200 html template' do
        let(:template) { 'new' }
      end
    end
  end

  describe '#create' do
    let(:email) { 'email' }
    let(:password) { 'password' }

    def do_create
      post :create, params: { email: email, password: password }
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_create }

      include_examples 'not authorized'
    end

    context 'when the teacher is not authorized' do
      let(:auth_create_service) { instance_double(Auth::LogIn, run: auth_result) }

      before do
        allow(Auth::LogIn)
          .to receive(:new)
            .with(
              context: controller,
              email: email,
              password: password
            ) { auth_create_service }

        do_create
      end

      context 'when the session can be created' do
        let(:auth_result) { true }

        it 'redirects to root_path' do
          expect(response).to redirect_to(root_path)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(SessionController::LOG_IN_MESSAGE)
        end
      end

      context 'when the session cannot be created' do
        let(:auth_result) { false }

        include_examples 'render 200 html template' do
          let(:template) { 'new' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(SessionController::WRONG_CREDENTIALS_MESSAGE)
        end
      end
    end

    describe '#destroy' do
      def do_destroy
        delete :destroy
      end

      context 'when the teacher is not authorized' do
        before do
          expect(Auth::Destroy).not_to receive(:new)

          do_destroy
        end

        include_examples 'not authorized'
      end

      context 'when the teacher is authorized' do
        let(:auth_destroy_service) { instance_double(Auth::Destroy, run: true) }

        include_context 'with current teacher'

        before do
          allow(Auth::Destroy)
            .to receive(:new)
              .with(
                context: controller
              ) { auth_destroy_service }

          expect(auth_destroy_service).to receive(:run)

          do_destroy
        end

        it 'redirects to root_path' do
          expect(response).to redirect_to(root_path)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(SessionController::LOG_OUT_MESSAGE)
        end
      end
    end
  end
end
