FactoryBot.define do
  factory :client do
    name { "Test Client" }
    sequence(:api_key) { |n| "api-key-#{n}" }
    payout_rate { 0.95 }
  end
end
