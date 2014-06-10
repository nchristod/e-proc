# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :procurement do
    name "MyString"
    proc_start_date "2014-06-10 00:31:16"
    proc_end_date "2014-06-10 00:31:16"
    proc_terms "MyText"
    proc_delivery_date "2014-06-10 00:31:16"
  end
end
