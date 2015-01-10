require 'rails_helper'

RSpec.describe Review, :type => :model do
  let!(:review) { FactoryGirl.create(:review) }

  it { should belong_to :homebrew }
  it { should belong_to(:reviewer).class_name("User") }

  it { should validate_presence_of :homebrew }
  it { should validate_presence_of :reviewer }
  it { should validate_presence_of :rating }
  it { should validate_inclusion_of(:rating).in_range(1..5) }
  it { should validate_uniqueness_of(:homebrew).scoped_to(:reviewer_id) }
end
