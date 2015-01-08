require 'rails_helper'

RSpec.describe Homebrew, :type => :model do
  let!(:homebrew) { FactoryGirl.create(:homebrew) }

  it { should belong_to :user }

  it { should validate_presence_of :user }
  it { should validate_presence_of :name }
  it { should validate_presence_of :date_brewed }
  it { should validate_uniqueness_of(:name).scoped_to(:date_brewed)
    .with_message("You already added this beer.") }
end
