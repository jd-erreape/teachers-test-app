# frozen_string_literal: true

class CoursesController < ApplicationController
  CREATE_SUCCESS_MESSAGE = 'Course has been created and you have been registered on it'
  COURSE_DOESNT_EXIST_MESSAGE = 'The Course requested does not exist'

  before_action :require_current_teacher, only: %i[new create]
  before_action :set_no_cache_headers

  def index
    # The includes here is necessary to avoid n + 1
    # problem whenever we check in the index view if
    # a teacher is imparting or not a course
    @courses = Course.includes(:teachers).all
  end

  def show
    @course = Course.includes(:teachers).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to courses_path, alert: COURSE_DOESNT_EXIST_MESSAGE
  end

  def new
    @course = Course.new
  end

  def create
    @course = course_creation_service.run

    if @course.valid?
      redirect_to courses_path, notice: CREATE_SUCCESS_MESSAGE
    else
      render 'new'
    end
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end

  def course_creation_service
    Course::Creation.new(
      teacher: current_teacher,
      course_params: course_params
    )
  end
end
