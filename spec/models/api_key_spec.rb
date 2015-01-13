require 'rails_helper'

RSpec.describe APIKey, :type => :model do
  include ActiveSupport::Testing::TimeHelpers

  describe "associations" do
    it { should belong_to :user }
  end

  describe "validations" do
    subject { FactoryGirl.build(:api_key, expires_at: Time.now) }

    it { should validate_presence_of :user }
    it { should validate_uniqueness_of :access_token }
  end

  describe "before_validation callback" do
    it "generates an access token" do
      user = FactoryGirl.build_stubbed(:user)
      api_key = APIKey.create!(user: user)

      expect(api_key.access_token).to_not be_nil
    end

    it "sets an expires_at" do
      travel_to Time.zone.at(0) do
        user = FactoryGirl.build_stubbed(:user)
        api_key = APIKey.create!(user: user)

        expect(api_key.expires_at).to eq 30.days.from_now
      end
    end

    it "uses provided expires_at if given" do
      travel_to Time.zone.at(0) do
        user = FactoryGirl.build_stubbed(:user)
        expires_at = 10.days.from_now
        api_key = APIKey.create!(user: user, expires_at: expires_at)

        expect(api_key.expires_at).to eq expires_at
      end
    end
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
