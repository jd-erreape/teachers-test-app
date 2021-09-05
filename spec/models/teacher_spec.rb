# frozen_string_literal: true

require 'rails_helper'
require_relative '../constants/emails'
require_relative './shared/examples/gives_votes'
require_relative './shared/examples/receives_votes'

RSpec.describe Teacher, type: :model do
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_values(*VALID_EMAILS).for(:email) }
  it { is_expected.not_to allow_values(*INVALID_EMAILS).for(:email) }
  it { is_expected.to have_many(:teacher_courses).dependent(:destroy) }
  it { is_expected.to have_many(:courses).through(:teacher_courses) }

  include_examples 'receives votes'
  include_examples 'gives votes'
end
