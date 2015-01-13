FactoryGirl.define do
  factory :api_key do
    user
    sequence(:access_token) { |n| "#{n}c6f329e93bf8bb93871966b763d189c"}
    expires_at { Time.zone.now + 1.week }
  end
end
