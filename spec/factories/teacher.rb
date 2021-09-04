# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
