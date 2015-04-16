# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    offer_technical { Faker::Lorem.sentence }
    offer_economical { Faker::Number.number(3) }
    delivery_date { Faker::Date.forward(20) }
    user
    product
    procurement
  end
end
