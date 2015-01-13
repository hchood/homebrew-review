require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "associations" do
    it { should have_many(:homebrews).dependent(:destroy) }
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:inverse_friendships).dependent(:destroy) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:inverse_friends).through(:inverse_friendships) }
    it { should have_many(:api_keys).dependent(:destroy) }
  end

  describe "validations" do
    let!(:user) { FactoryGirl.create(:user) }

    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it { should validate_uniqueness_of :email}
  end



  describe "#all_friends" do
    let!(:user) { FactoryGirl.create(:user) }
    
    it "returns all a user's friends" do
      friendships = FactoryGirl.create_list(:friendship, 2, user: user)
      inverse_friendships = FactoryGirl.create_list(:friendship, 2, friend: user)

      friends = user.all_friends

      friendships.each do |friendship|
        expect(friends).to include friendship.friend
      end

      inverse_friendships.each do |friendship|
        expect(friends).to include friendship.user
      end

      expect(friends.count).to eq 4
    end

    it "returns empty array if the user has no friends" do
      expect(user.all_friends).to eq []
    end
  end
end
