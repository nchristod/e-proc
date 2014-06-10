# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    offer_technical "MyText"
    offer_economical "MyText"
    delivery_date "2014-06-10 00:35:16"
  end
end
