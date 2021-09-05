# frozen_string_literal: true

module VotesHelper
  REMOVE_VOTE_MESSAGE = 'Remove Vote'
  VOTE_MESSAGE = 'Vote'
  REMOVE_VOTE_BUTTON_CLASS = 'danger'
  VOTE_BUTTON_CLASS = 'primary'

  def votes_form_method(already_voted)
    already_voted ? :delete : :post
  end

  def votes_button_message(already_voted)
    already_voted ? REMOVE_VOTE_MESSAGE : VOTE_MESSAGE
  end

  def votes_button_class(already_voted)
    already_voted ? REMOVE_VOTE_BUTTON_CLASS : VOTE_BUTTON_CLASS
  end
end
