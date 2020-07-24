# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    tag
    body { '今日のご飯はカレー' }
  end
end
