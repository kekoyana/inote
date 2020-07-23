# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "TagName-#{n}" }
  end
end
