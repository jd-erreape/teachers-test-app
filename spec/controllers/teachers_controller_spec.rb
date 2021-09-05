# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/contexts/current_teacher'
require_relative './shared/examples/render_200_html_template'
require_relative './shared/examples/not_authorized'
require_relative './shared/examples/index_with_resources'
require_relative './shared/examples/show_with_resource'

RSpec.describe TeachersController, type: :controller do
  describe '#index' do
    include_examples 'index with resources', :teacher
  end

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

      it 'assigns a new teacher' do
        expect(assigns['teacher'].class).to eq(Teacher)
      end

      it 'does not persist the assigned teacher' do
        expect(assigns['teacher']).not_to be_persisted
      end
    end
  end

  describe '#show' do
    include_examples 'show with resource', :teacher
  end

  describe '#create' do
    def do_create
      post :create, params: { teacher: teacher_params }
    end

    context 'when the teacher is authorized' do
      # Teacher params wont matter as we wont be allowing
      # the action to be executed because of the current teacher
      # being present
      let(:teacher_params) { {} }

      include_context 'with current teacher'

      before { do_create }

      include_examples 'not authorized'
    end

    context 'when the teacher is not authorized' do
      before { do_create }

      # NOTE: We have to assign the password and the password_confirmation
      # fields manually here and not relly on the ones that were used
      # when calling FactoryBot because Rails, once the fields have
      # been assigned to the model, won't return them anymore as part
      # of attributes method, it will just return the password_digest

      context 'when teacher params are valid' do
        let(:teacher_params) do
          build(:teacher).attributes.merge(
            password: 'password',
            password_confirmation: 'password'
          )
        end

        it 'assigns the created teacher' do
          expect(assigns['teacher'].class).to eq(Teacher)
        end

        it 'persists the assigned teacher' do
          expect(assigns['teacher']).to be_persisted
        end

        it 'redirects to root_path' do
          expect(response).to redirect_to(root_path)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(TeachersController::CREATE_SUCCESS_MESSAGE)
        end

        it 'logs in the teacher' do
          expect(session[:teacher_id]).to eq(assigns['teacher'].id)
        end
      end

      context 'when teacher params are invalid' do
        # According to our previous NOTE, when calling attributes
        # on the built model to retrieve the params we're going to
        # use, password and password_confirmation won't be returned
        # so the model will be already invalid when we try to save it

        let(:teacher_params) { build(:teacher).attributes }

        include_examples 'render 200 html template' do
          let(:template) { 'new' }
        end

        it 'fill errors in the record' do
          expect(assigns['teacher'].errors).not_to be_empty
        end
      end
    end
  end
end
