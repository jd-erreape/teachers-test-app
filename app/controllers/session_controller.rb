# frozen_string_literal: true

class SessionController < ApplicationController
  LOG_IN_MESSAGE = 'Logged in'
  LOG_OUT_MESSAGE = 'You have been logged out'
  WRONG_CREDENTIALS_MESSAGE = 'Email or password is invalid'

  before_action :require_not_current_teacher, only: %i[new create]
  before_action :require_current_teacher, only: %i[destroy]

  def new; end

  def create
    if create_session
      redirect_to root_url, notice: LOG_IN_MESSAGE
    else
      flash.now.alert = WRONG_CREDENTIALS_MESSAGE

      render 'new'
    end
  end

  def destroy
    destroy_session

    redirect_to root_url, notice: LOG_OUT_MESSAGE
  end

  private

  def create_session
    Auth::LogIn.new(
      context: self,
      email: params[:email],
      password: params[:password]
    ).run
  end

  def destroy_session
    Auth::Destroy.new(context: self).run
  end
end
