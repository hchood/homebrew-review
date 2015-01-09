require 'rails_helper'

RSpec.describe Friendship, :type => :model do
  let!(:friendship) { FactoryGirl.create(:friendship) }

  it { should belong_to :user }
  it { should belong_to(:friend).class_name("User") }

  it { should validate_presence_of :user }
  it { should validate_presence_of :friend }

  it { should validate_uniqueness_of(:user).scoped_to(:friend_id) }
end
