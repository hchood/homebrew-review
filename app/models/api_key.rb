class APIKey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :access_token,
    presence: true,
    uniqueness: true
  validates :expires_at, presence: true
end
