FactoryBot.define do
  factory :client_product do
    association :client
    association :product
  end
end
