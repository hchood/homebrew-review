class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  paginates_per 20

  has_many :homebrews,
    foreign_key: :brewer_id,
    dependent: :destroy
  has_many :friendships,
    dependent: :destroy
  has_many :inverse_friendships,
    class_name: "Friendship",
    foreign_key: :friend_id,
    dependent: :destroy
  has_many :friends,
    through: :friendships
  has_many :inverse_friends,
    through: :inverse_friendships,
    source: :user
  has_many :api_keys,
    dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_api_key

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_friend?(user)
    self != user && !friends_with?(user)
  end

  def friends_with?(user)
    !friendship_for(user).nil?
  end

  def friendship_for(user)
    friendships.find_by(friend: user) ||
      inverse_friendships.find_by(user: user)
  end

  def all_friends
    friends_list = friends + inverse_friends
    friends_list.sort_by { |friend| [friend.last_name, friend.first_name] }
  end

  def can_review?(homebrew)
    (brewed?(homebrew) || friends_with?(homebrew.brewer)) &&
      !reviewed?(homebrew)
  end

  def reviewed?(homebrew)
    homebrew.reviews.persisted.any? { |review| review.reviewer == self }
  end

  def brewed?(homebrew)
    homebrew.brewer == self
  end

  private

  def create_api_key
    api_keys.create
  end
end
