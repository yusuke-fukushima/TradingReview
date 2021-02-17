FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    postal_code { Faker::Address.postcode }
    address { Faker::Address.city }
    password { 'password' }
    password_confirmation { 'password' }
  end
end