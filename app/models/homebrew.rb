class Homebrew < ActiveRecord::Base
  paginates_per 20

  belongs_to :brewer, class_name: "User"
  has_many :reviews do
    def persisted
      select { |review| review if review.persisted? }
    end
  end
  has_many :taggings
  has_many :tags, through: :taggings

  validates :brewer, presence: true
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
    "#{brewer.first_name} #{brewer.last_name}"
  end

  def tag_names
    names = tags.pluck(:name).sort_by { |name| name.downcase }
    names.join(", ")
  end

  def date_brewed_cannot_be_in_future
    errors.add(:date_brewed, "can't be in the future") if
      !date_brewed.blank? && date_brewed > Date.today
  end
end
