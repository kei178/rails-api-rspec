require 'ffaker'

FactoryBot.define do
  factory :task do
    association :user
    title { FFaker::Lorem.sentence }
    is_completed { false }
  end
end