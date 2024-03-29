# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :procurement do
    name "My procurement"
    proc_terms "My terms"
    proc_start_date Date.today
    proc_end_date Date.today + 2
    proc_delivery_date Date.today + 10
    user
    
    trait :underbidding do
      category 0
    end

    trait :meat do
      category 1
    end

    factory :expired_procurement do
      proc_start_date Date.today - 10
      proc_end_date Date.today - 2
      proc_delivery_date Date.today + 10
    end

  end
end
