FactoryBot.define do
  factory :gift_card do
    association :product
    association :client
    sequence(:activation_number) { |n| "act-num-#{n}" }
    sequence(:pin) { |n| "pin-#{n}" }
    purchase_details { "some details" }
    status { :active }
    amount { 10.0 }
  end
end
