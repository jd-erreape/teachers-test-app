require 'rails_helper'
require_relative '../constants/emails'

RSpec.describe Teacher, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_values(*VALID_EMAILS).for(:email) }
  it { should_not allow_values(*INVALID_EMAILS).for(:email)}
end
