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

  describe ".from_request" do
    it "finds access token from request authorization" do
      api_key = FactoryGirl.create(:api_key)
      request = double(authorization: "Token token=#{api_key.access_token}")

      expect(APIKey.from_request(request)).to eq api_key
    end

    it "fails gracefully when request has no authorization" do
      request = double(authorization: nil)
      expect { APIKey.from_request(request) }.to_not raise_error
    end
  end
end
