class Homebrew < ActiveRecord::Base
  paginates_per 20

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  validates :user, presence: true
  validates :name,
    presence: true,
    uniqueness: { scope: :date_brewed,
      message: "You already added this beer." }
  validates :date_brewed, presence: true
  validate :date_brewed_cannot_be_in_future

  def year_brewed
    date_brewed.year
  end

  def month_brewed
    month = date_brewed.month
    Date::MONTHNAMES[month]
  end

  def brewer_name
    "#{user.first_name} #{user.last_name}"
  end

  def date_brewed_cannot_be_in_future
    errors.add(:date_brewed, "can't be in the future") if
      !date_brewed.blank? && date_brewed > Date.today
  end
end
