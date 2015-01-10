FactoryGirl.define do
  factory :review do
    homebrew
    reviewer
    rating { rand(1..5) }
    body "Sweet beer bro"
  end
end
