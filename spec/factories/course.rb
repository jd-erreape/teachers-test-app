# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Lorem.unique.sentence }
  end
end
