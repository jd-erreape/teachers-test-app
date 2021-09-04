# frozen_string_literal: true

require 'rails_helper'

describe Auth::Destroy do
  let(:session) { { teacher_id: 1 } }
  let(:context) { instance_double(ApplicationController, session: session) }
  let(:instance) { described_class.new(context: context) }

  describe '#run' do
    subject(:destroy) { instance.run }

    it 'sets context session teacher_id value as nil' do
      destroy

      expect(session[:teacher_id]).to be_blank
    end
  end
end
