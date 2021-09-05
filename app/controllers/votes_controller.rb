# frozen_string_literal: true

class VotesController < ApplicationController
  CREATE_SUCCESS_MESSAGE = 'You have voted!'
  CREATE_ERROR_MESSAGE = 'There was an error registering your vote'
  DESTROY_SUCCESS_MESSAGE = 'You have unregister your vote'
  DESTROY_ERROR_MESSAGE = 'There was an error unregistering your vote'

  before_action :require_current_teacher, only: %i[create destroy]

  def create
    @vote = Vote.new(vote_params.merge(voter: current_teacher))

    if @vote.save
      redirect_back_with(:notice, CREATE_SUCCESS_MESSAGE)
    else
      redirect_back_with(:alert, CREATE_ERROR_MESSAGE)
    end
  end

  def destroy
    @vote = current_teacher.votes_given.find_by(id: params[:id])

    if @vote&.destroy
      redirect_back_with(:notice, DESTROY_SUCCESS_MESSAGE)
    else
      redirect_back_with(:alert, DESTROY_ERROR_MESSAGE)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:voted_type, :voted_id)
  end

  def redirect_back_with(level, message)
    redirect_back fallback_location: root_path, **{ level => message }
  end
end
