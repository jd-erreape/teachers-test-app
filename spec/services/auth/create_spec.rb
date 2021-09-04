# frozen_string_literal: true

require 'rails_helper'

describe Auth::Create do
  let(:session) { {} }
  let(:context) { instance_double(ApplicationController, session: session) }
  let(:teacher_id) { 1 }
  let(:instance) { described_class.new(context: context, teacher_id: teacher_id) }

  describe '#run' do
    subject(:create) { instance.run }

    it 'sets context session teacher_id value' do
      create

      expect(session[:teacher_id]).to eq(teacher_id)
    end
  end
end
