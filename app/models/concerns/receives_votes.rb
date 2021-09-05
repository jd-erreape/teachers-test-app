# frozen_string_literal: true

module ReceivesVotes
  extend ActiveSupport::Concern

  included do
    has_many :votes_received, as: :voted, class_name: 'Vote', dependent: :destroy
  end
end
