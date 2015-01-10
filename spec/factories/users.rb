FactoryGirl.define do
  factory :user, aliases: [:friend, :reviewer] do
    first_name "Bob"
    sequence(:last_name) { |n| "Loblaw the #{n}" }
    sequence(:email) { |n| "#{n}th_bob@bobloblawlawblog.com" }
    password "supersecret"
  end
end
