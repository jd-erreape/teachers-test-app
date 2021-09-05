# frozen_string_literal: true

require 'rails_helper'
require_relative './shared/contexts/current_teacher'
require_relative './shared/examples/not_authorized'

RSpec.describe VotesController, type: :controller do
  describe '#create' do
    def do_create
      post :create, params: { vote: vote_params }
    end

    context 'when the teacher is not authorized' do
      # Vote params wont matter as we wont be allowing
      # the action to be executed because of the current teacher
      # being present
      let(:vote_params) { {} }

      before { do_create }

      include_examples 'not authorized'
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_create }

      context 'when vote params are valid' do
        let(:course) { create(:course) }
        let(:vote_params) { build(:vote, voted: course).attributes }

        it 'assigns the created vote' do
          expect(assigns['vote'].class).to eq(Vote)
        end

        it 'persists the assigned vote' do
          expect(assigns['vote']).to be_persisted
        end

        # Testing redirect back with rspec is not trivial and we would need
        # to mock request.env['HTTP_REFERER'] in order to verify the behaviour,
        # for the assignment we are gonna obviate this and just check that it redirects
        it 'redirects' do
          expect(response.status).to eq(302)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:notice]).to eq(VotesController::CREATE_SUCCESS_MESSAGE)
        end
      end

      context 'when vote params are invalid' do
        let(:vote_params) { build(:vote).attributes.merge(voted_id: nil) }

        before { do_create }

        it 'redirects' do
          expect(response.status).to eq(302)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(VotesController::CREATE_ERROR_MESSAGE)
        end
      end
    end
  end

  describe '#destroy' do
    def do_destroy
      delete :destroy, params: { id: vote_id }
    end

    context 'when the teacher is not authorized' do
      # Vote params wont matter as we wont be allowing
      # the action to be executed because of the current teacher
      # being present
      let(:vote_id) { -1 }

      before { do_destroy }

      include_examples 'not authorized'
    end

    context 'when the teacher is authorized' do
      include_context 'with current teacher'

      before { do_destroy }

      context 'when the vote exists' do
        context 'when the vote belongs to the current_teacher' do
          let(:vote) { create(:vote, voter: current_teacher) }
          let(:vote_id) { vote.id }

          it 'assigns the vote to destroy' do
            expect(assigns['vote']).to eq(vote)
          end

          it 'destroy the assigned vote' do
            expect(assigns['vote']).not_to be_persisted
          end

          it 'redirects' do
            expect(response.status).to eq(302)
          end

          it 'sets proper flash message' do
            expect(response.request.flash[:notice]).to eq(VotesController::DESTROY_SUCCESS_MESSAGE)
          end
        end

        context 'when the vote does not belong to the current teacher' do
          let(:vote) { create(:vote, voter: build(:teacher)) }
          let(:vote_id) { vote.id }

          before { do_destroy }

          it 'redirects' do
            expect(response.status).to eq(302)
          end

          it 'sets proper flash message' do
            expect(response.request.flash[:alert]).to eq(VotesController::DESTROY_ERROR_MESSAGE)
          end
        end
      end

      context 'when the vote does not exist' do
        let(:vote_id) { -1 }

        before { do_destroy }

        it 'redirects' do
          expect(response.status).to eq(302)
        end

        it 'sets proper flash message' do
          expect(response.request.flash[:alert]).to eq(VotesController::DESTROY_ERROR_MESSAGE)
        end
      end
    end
  end
end
