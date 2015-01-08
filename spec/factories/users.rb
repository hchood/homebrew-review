FactoryGirl.define do
  factory :user do
    first_name "Bob"
    last_name "Loblaw"
    sequence(:email) { |n| "#{n}th_bob@bobloblawlawblog.com" }
    password "supersecret"
  end
end
