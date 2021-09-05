# frozen_string_literal: true

module GivesVotes
  extend ActiveSupport::Concern

  included do
    has_many :votes_given, as: :voter, class_name: 'Vote', dependent: :destroy
  end

  def voted_for?(element)
    !!votes_given.where(voted: element).first
  end
end
