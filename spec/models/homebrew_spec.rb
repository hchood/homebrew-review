require 'rails_helper'

RSpec.describe Homebrew, :type => :model do
  let!(:homebrew) { FactoryGirl.create(:homebrew) }

  it { should belong_to(:brewer).class_name("User") }
  it { should have_many :reviews }
  it { should have_many :taggings }
  it { should have_many(:tags).through(:taggings) }

  it { should validate_presence_of :brewer }
  it { should validate_presence_of :name }
  it { should validate_presence_of :date_brewed }

  it { should validate_uniqueness_of(:name).scoped_to(:date_brewed)
    .with_message("You already added this beer.") }

  it { should have_valid(:date_brewed).when(Date.today, 2.days.ago, 1.year.ago) }
  it { should_not have_valid(:date_brewed).when(Date.tomorrow, 1.week.from_now) }
end
