# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Beer.unique.name }
  end
end
