FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password123" }
    full_name { "Test Admin User" }
  end
end
