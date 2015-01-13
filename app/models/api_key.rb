class APIKey < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :access_token,
    presence: true,
    uniqueness: true
  validates :expires_at, presence: true

  before_validation :set_access_token, :set_expires_at, on: :create

  def self.from_request(request)
    return unless request.authorization

    access_token = request.authorization.gsub(/\AToken token=/, '')
    find_by(access_token: access_token)
  end

  private

  def set_access_token
    return if access_token.present?

    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: self.access_token)
  end


  def set_expires_at
    return if expires_at.present?

    self.expires_at = Time.now + 30.days
  end
end
