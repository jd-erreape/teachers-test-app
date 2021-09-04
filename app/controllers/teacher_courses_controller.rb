# frozen_string_literal: true

class TeacherCoursesController < ApplicationController
  CREATE_SUCCESS_MESSAGE = 'You were successfully registered in the Course'
  CREATE_ERROR_MESSAGE = 'There was some error registering you in the Course'
  DESTROY_SUCCESS_MESSAGE = 'You were successfully unregistered in the Course'
  DESTROY_ERROR_MESSAGE = 'There was some error unregistering you in the Course'

  before_action :require_current_teacher, only: %i[create destroy]

  def create
    with_not_found_rescue(CREATE_ERROR_MESSAGE) do
      @teacher_course = TeacherCourse.new(teacher: current_teacher, course: course)

      if @teacher_course.save
        flash.now[:notice] = CREATE_SUCCESS_MESSAGE
      else
        flash.now[:alert] = CREATE_ERROR_MESSAGE
      end

      render 'update_registered'
    end
  end

  def destroy
    with_not_found_rescue(DESTROY_ERROR_MESSAGE) do
      @teacher_course = TeacherCourse.where(teacher: current_teacher, course: course).first

      if @teacher_course&.destroy
        flash.now[:notice] = DESTROY_SUCCESS_MESSAGE
      else
        flash.now[:alert] = DESTROY_ERROR_MESSAGE
      end

      render 'update_registered'
    end
  end

  private

  def course
    @course = Course.find(params[:id])
  end

  def with_not_found_rescue(error_message)
    yield
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = error_message

    render 'update_registered'
  end
end
