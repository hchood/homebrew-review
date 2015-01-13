class APIKey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :access_token,
    presence: true,
    uniqueness: true
  validates :expires_at, presence: true

  def self.from_request(request)
    return unless request.authorization

    access_token = request.authorization.gsub(/\AToken token=/, '')
    find_by(access_token: access_token)
  end
end
