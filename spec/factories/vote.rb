# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    for_teacher
    association :voter, factory: :teacher

    trait :for_teacher do
      association :voted, factory: :teacher
    end

    trait :for_course do
      association :voted, factory: :course
    end
  end
end
