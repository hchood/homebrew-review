FactoryGirl.define do
  factory :tag do
    sequence(:name) { |n| "#{n} hoppy" }
  end
end
