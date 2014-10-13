FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
    confirmed_at "2014-06-10 00:35:16"

    
    trait :admin do
      email 'testadmin@example.com'
      role 2
    end

    trait :supplier do
      email 'testsupplier@example.com'
      role 1
    end

    trait :simple do
      email 'testsimple@example.com'
      role 0
    end
  end

end
