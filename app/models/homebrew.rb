class Homebrew < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :name,
    presence: true,
    uniqueness: { scope: :date_brewed,
      message: "You already added this beer." }
  validates :date_brewed, presence: true

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
end
