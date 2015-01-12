require "rails_helper"

describe API::V1::HomebrewsController do
  describe "Fetching all homebrews" do
    it "returns all the homebrews, ordered by recency" do
      older_homebrew = FactoryGirl.create(:homebrew,
        created_at: Time.zone.now - 1.week)
      old_homebrew = FactoryGirl.create(:homebrew,
        created_at: Time.zone.now - 1.day)
      oldest_homebrew = FactoryGirl.create(:homebrew,
        created_at: Time.zone.now - 1.year)
      ordered_homebrews = [old_homebrew, older_homebrew, oldest_homebrew]

      get :index, {}, { "Accept" => "application/vnd.mycompany.com; version=1" }

      expect(response.status).to eq 200
      expect(response).to match_response_schema("homebrews")
    end
  end
end
