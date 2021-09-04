# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_teacher

  NOT_AUTHORIZED_MESSAGE = 'Not authorized'

  private

  def current_teacher
    # Using where and first instead of find just in case a Teacher is deleted while
    # its session has a teacher_id assigned, this way, Rails won't raise an error
    # and the behavior will be equivalent to the deleted teacher being logged out
    @current_teacher ||= Teacher.where(id: session[:teacher_id]).first if session[:teacher_id]
  end

  def require_current_teacher
    redirect_to root_path, alert: NOT_AUTHORIZED_MESSAGE unless current_teacher
  end

  def require_not_current_teacher
    redirect_to root_path, alert: NOT_AUTHORIZED_MESSAGE if current_teacher
  end

  def set_no_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Mon, 01 Jan 1990 00:00:00 GMT'
  end
end
