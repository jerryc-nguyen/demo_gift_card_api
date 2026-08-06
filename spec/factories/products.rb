FactoryBot.define do
  factory :product do
    association :brand
    name { "Test Product" }
    price { 10.0 }
    status { :active }
  end
end
