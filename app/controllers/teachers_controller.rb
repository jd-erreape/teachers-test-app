# frozen_string_literal: true

class TeachersController < ApplicationController
  CREATE_SUCCESS_MESSAGE = 'You have been signed up'

  before_action :require_not_current_teacher, only: %i[new create]

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
