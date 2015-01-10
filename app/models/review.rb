class Review < ActiveRecord::Base
  belongs_to :homebrew
  belongs_to :reviewer, class_name: "User"

  validates :homebrew,
    presence: true,
    uniqueness: { scope: :reviewer_id }
  validates :reviewer, presence: true
  validates :rating,
    presence: true,
    inclusion: { in: 1..5 }
end
