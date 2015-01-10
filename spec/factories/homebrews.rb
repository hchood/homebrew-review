FactoryGirl.define do
  factory :homebrew do
    brewer
    
    sequence(:name) { |n| "#{n} Bob's Best IPA" }
    date_brewed Faker::Date.backward(30)
    description Faker::Lorem.paragraph
  end
end
