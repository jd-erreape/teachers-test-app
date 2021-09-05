# frozen_string_literal: true

module Votes
  class Builder
    class VotedNotDefined < StandardError; end

    def initialize(voter:, voted:)
      raise VotedNotDefined unless voted

      @voter = voter
      @voted = voted
    end

    def run
      return new_vote unless voter

      existent_vote || new_vote
    end

    private

    attr_reader :voter, :voted

    def existent_vote
      voter.votes_given.find_by(voted: voted)
    end

    def new_vote
      Vote.new(voter: voter, voted: voted)
    end
  end
end
