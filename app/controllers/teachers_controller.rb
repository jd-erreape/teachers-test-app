# frozen_string_literal: true

class TeachersController < ApplicationController
  CREATE_SUCCESS_MESSAGE = 'You have been signed up'
  RESOURCE_DOESNT_EXIST_MESSAGE = 'The Teacher requested does not exist'

  before_action :require_not_current_teacher, only: %i[new create]

  def index
    @teachers = Teacher.includes(:courses, :votes_received).all
  end

  def show
    @teacher = Teacher.includes(:courses, :votes_received).find(params[:id])
    @vote = Votes::Builder.new(voter: current_teacher, voted: @teacher).run
  rescue ActiveRecord::RecordNotFound
    redirect_to teachers_path, alert: RESOURCE_DOESNT_EXIST_MESSAGE
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      Auth::Create.new(context: self, teacher_id: @teacher.id).run

      redirect_to root_url, notice: CREATE_SUCCESS_MESSAGE
    else
      render 'new'
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:email, :password, :password_confirmation)
  end
end
