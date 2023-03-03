# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    association :author, factory: :employee

    sequence(:title) { |n| "title#{n}" }
    sequence(:content) { |n| "content#{n}" }
    sequence(:deleted_at) { [Time.now, nil].sample }
  end
end
