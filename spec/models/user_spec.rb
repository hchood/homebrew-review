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

  describe "after_create callback" do
    it "generates an API key" do
      user = FactoryGirl.create(:user)

      expect(user.api_keys.count).to eq 1
    end
  end

  describe "#api_key" do
    it "returns active API key for user" do
      user = FactoryGirl.build_stubbed(:user)
      api_key = FactoryGirl.create(:api_key, user: user)

      expect(user.api_key).to eq api_key
    end

    it "generates a new API key if user has no active API keys" do
      user = FactoryGirl.build_stubbed(:user)
      inactive_api_key = FactoryGirl.create(:api_key,
        user: user, expires_at: 1.day.ago)

      expect(user.api_key).to_not eq inactive_api_key
      expect(user.api_key.class).to eq APIKey 
    end
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
