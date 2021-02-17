FactoryBot.define do
  factory :review do
    value { Faker::Number.between(from: 1, to: 5) }
    good_point { Faker::Lorem }
    bad_point { Faker::Lorem }
    improvement_point { Faker::Lorem }
    customer
    item
  end
end