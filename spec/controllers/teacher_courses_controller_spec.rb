# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/contexts/current_teacher'
require_relative './shared/examples/render_200_javascript_template'
require_relative './shared/examples/not_authorized'

RSpec.describe TeacherCoursesController, type: :controller do
  describe '#create' do
    def do_create
      post :create, params: { id: course_id }, xhr: true
    end

    context 'when the teacher is not authorized' do
      # Course params wont matter as we wont be allowing
      # the action to be executed because of the current teacher
      # being present
      let(:course_id) { 1 }

      before { do_create }

      include_examples 'not authorized'
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_create }

      context 'when teacher course params are valid (course exist and the teacher is not registered yet)' do
        let(:course) { create(:course) }
        let(:course_id) { course.id }

        it 'assigns the course' do
          expect(assigns['course']).to eq(course)
        end

        it 'assigns the created teacher course' do
          expect(assigns['teacher_course'].class).to eq(TeacherCourse)
        end

        it 'persists the assigned teacher course' do
          expect(assigns['teacher_course']).to be_persisted
        end

        include_examples 'render 200 javascript template' do
          let(:template) { 'update_registered' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(TeacherCoursesController::CREATE_SUCCESS_MESSAGE)
        end
      end

      context 'when teacher course params are invalid (the association already exists)' do
        let(:course) { create(:course) }
        let(:teacher_course) { create(:teacher_course, teacher: current_teacher, course: course) }
        let(:course_id) { course.id }

        before { do_create }

        include_examples 'render 200 javascript template' do
          let(:template) { 'update_registered' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(TeacherCoursesController::CREATE_ERROR_MESSAGE)
        end
      end

      context 'when teacher course params are invalid (the course doesnt exist)' do
        let(:course_id) { -1 }

        before { do_create }

        include_examples 'render 200 javascript template' do
          let(:template) { 'update_registered' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(TeacherCoursesController::CREATE_ERROR_MESSAGE)
        end
      end
    end
  end

  describe '#destroy' do
    def do_destroy
      delete :destroy, params: { id: course_id }, xhr: true
    end

    context 'when the teacher is not authorized' do
      # Course params wont matter as we wont be allowing
      # the action to be executed because of the current teacher
      # being present
      let(:course_id) { 1 }

      before { do_destroy }

      include_examples 'not authorized'
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      context 'when teacher course params are valid (course exist and teacher_course exist)' do
        let(:course) { create(:course) }
        let!(:teacher_course) { create(:teacher_course, teacher: current_teacher, course: course) }
        let(:course_id) { course.id }

        before { do_destroy }

        it 'assigns the course' do
          expect(assigns['course']).to eq(course)
        end

        it 'assigns the teacher course to destroy' do
          expect(assigns['teacher_course']).to eq(teacher_course)
        end

        it 'destroys the assigned teacher course' do
          expect(assigns['teacher_course']).not_to be_persisted
        end

        include_examples 'render 200 javascript template' do
          let(:template) { 'update_registered' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(TeacherCoursesController::DESTROY_SUCCESS_MESSAGE)
        end
      end

      context 'when teacher course params are invalid (teacher_course does not exist)' do
        let(:course) { create(:course) }
        let(:course_id) { course.id }

        before { do_destroy }

        include_examples 'render 200 javascript template' do
          let(:template) { 'update_registered' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(TeacherCoursesController::DESTROY_ERROR_MESSAGE)
        end
      end

      context 'when teacher course params are invalid (course does not exist)' do
        let(:course_id) { -1 }

        before { do_destroy }

        include_examples 'render 200 javascript template' do
          let(:template) { 'update_registered' }
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(TeacherCoursesController::DESTROY_ERROR_MESSAGE)
        end
      end
    end
  end
end
