FactoryBot.define do
  factory :customer do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    postal_code { Faker::Internet.email }
    address { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end