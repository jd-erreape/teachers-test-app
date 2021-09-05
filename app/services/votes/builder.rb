# frozen_string_literal: true

# Service in charge of building a Vote object
# given the voter and the voted instances
# we will always require a voted element so
# if it is not provided we will be raising a
# Votes::Builder::VotedNotDefined error on
# construction time
module Votes
  class Builder
    class VotedNotDefined < StandardError; end

    def initialize(voter:, voted:)
      raise VotedNotDefined unless voted

      @voter = voter
      @voted = voted
    end

    # Builds and return the Vote object given the
    # voter and the voted, this method will always
    # return a Vote object, this object could be
    # a new non persisted Vote if there is no voter
    # (i.e. if we are trying to build a vote for a non
    # logged in user) or if there is no Vote done
    # for the voter and the voted already
    # If there is already a existent vote, the method
    # will return the actual Vote record for the
    # voter and voted
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
