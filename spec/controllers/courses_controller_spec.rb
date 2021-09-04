# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/contexts/current_teacher'
require_relative './shared/examples/render_200_html_template'
require_relative './shared/examples/not_authorized'

RSpec.describe CoursesController, type: :controller do
  describe '#index' do
    let!(:courses) { 3.times.map { create(:course) } }

    def do_index
      get :index
    end

    before { do_index }

    include_examples 'render 200 html template' do
      let(:template) { 'index' }
    end

    it 'assigns the current courses' do
      expect(assigns['courses']).to eq(courses)
    end
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
    let(:course) { create(:course) }

    def do_show(course_id)
      get :show, params: { id: course_id }
    end

    context 'when the course requested exist' do
      before { do_show(course.id) }

      include_examples 'render 200 html template' do
        let(:template) { 'show' }
      end

      it 'assigns the course' do
        expect(assigns['course']).to eq(course)
      end
    end

    context 'when the course requested does not exist' do
      before { do_show(-1) }

      it 'redirects to courses_path' do
        expect(response).to redirect_to(courses_path)
      end

      it 'sets proper flash message' do
        expect(response.request.flash[:alert]).to eq(CoursesController::COURSE_DOESNT_EXIST_MESSAGE)
      end
    end
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
