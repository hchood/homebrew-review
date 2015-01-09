class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  paginates_per 20

  has_many :homebrews,
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

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_friend?(user)
    self != user
  end
end
