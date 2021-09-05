# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/contexts/current_teacher'
require_relative './shared/examples/render_200_html_template'
require_relative './shared/examples/not_authorized'
require_relative './shared/examples/index_with_resources'
require_relative './shared/examples/show_with_resource'

RSpec.describe CoursesController, type: :controller do
  describe '#index' do
    include_examples 'index with resources', :course
  end

  describe '#new' do
    def do_new
      get :new
    end

    context 'when the teacher is not authorized' do
      before { do_new }

      include_examples 'not authorized'
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_new }

      include_examples 'render 200 html template' do
        let(:template) { 'new' }
      end

      it 'assigns a new course' do
        expect(assigns['course'].class).to eq(Course)
      end

      it 'does not persist the assigned course' do
        expect(assigns['course']).not_to be_persisted
      end
    end
  end

  describe '#show' do
    include_examples 'show with resource', :course
  end

  describe '#create' do
    def do_create
      post :create, params: { course: course_params }
    end

    context 'when the teacher is not authorized' do
      # Course params wont matter as we wont be allowing
      # the action to be executed because of the current teacher
      # being present
      let(:course_params) { {} }

      before { do_create }

      include_examples 'not authorized'
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_create }

      context 'when course params are valid' do
        let(:course_params) { build(:course).attributes }

        it 'assigns the created course' do
          expect(assigns['course'].class).to eq(Course)
        end

        it 'persists the assigned course' do
          expect(assigns['course']).to be_persisted
        end

        it 'redirects to courses_path' do
          expect(response).to redirect_to(courses_path)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(CoursesController::CREATE_SUCCESS_MESSAGE)
        end

        it 'registers the current_teacher in the course' do
          expect(assigns['course'].teachers).to include(current_teacher)
        end
      end

      context 'when course params are invalid' do
        let(:course_params) { build(:course).attributes.merge(title: nil) }

        before { do_create }

        include_examples 'render 200 html template' do
          let(:template) { 'new' }
        end

        it 'fill errors in the record' do
          expect(assigns['course'].errors).not_to be_empty
        end
      end
    end
  end
end
