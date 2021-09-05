# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :voted, polymorphic: true
  belongs_to :voter, polymorphic: true

  validates :voted, presence: true
  validates :voter, presence: true

  # We need to validate the scoped uniqueness this way for polymorphic
  # associations as stated in the following Github thread
  # https://github.com/rails/rails/issues/34312#issuecomment-586870322
  validates :voted_id, uniqueness: { scope: %i[voted_type voter_id] }
  validates :voter_id, uniqueness: { scope: %i[voter_type voted_id] }
end
