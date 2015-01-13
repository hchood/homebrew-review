require 'rails_helper'

RSpec.describe APIKey, :type => :model do
  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do
    subject { FactoryGirl.build(:api_key, expires_at: Time.now) }

    it { should validate_presence_of :user }
    it { should validate_presence_of :access_token }
    it { should validate_presence_of :expires_at }

    it { should validate_uniqueness_of :access_token }
  end
end
