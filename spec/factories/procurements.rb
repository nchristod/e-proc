# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :procurement do
    name "My procurement"
    proc_terms "My terms"
    proc_start_date "2014-10-10"
    proc_end_date "2014-10-15"
    proc_delivery_date "2014-10-20"
    user

    trait :underbidding do
      category 0
    end

    trait :meat do
      category 1
    end

  end
end
