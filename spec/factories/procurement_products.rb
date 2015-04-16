# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :procurement_product do
    quantity "MyString"
    requirements "MyText"
    procurement
    product
  end
end
