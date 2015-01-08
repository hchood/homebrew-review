class Homebrew < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :name,
    presence: true,
    uniqueness: { scope: :date_brewed,
      message: "You already added this beer." }
  validates :date_brewed, presence: true
end
