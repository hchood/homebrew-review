require "rails_helper"

describe API::V1::UsersController do
  describe "Fetching all users" do
    it "returns all the users, ordered by last name, then first name" do
      last_user = FactoryGirl.create(:user, last_name: "Smith", first_name: "Zelda")
      first_user = FactoryGirl.create(:user)
      middle_user = FactoryGirl.create(:user, last_name: "Smith", first_name: "Alice")

      get :index, {}, { "Accept" => "application/vnd.mycompany.com; version=1" }

      expect(response.status).to eq 200
      expect(response).to match_response_schema("users")
    end
  end

  describe "Fetching a user" do
    it "returns a single user" do
      user = FactoryGirl.create(:user)

      get :show, { id: user.id }, {  "Accept" => "application/vnd.mycompany.com; version=1" }

      expect(response.status).to eq 200
      expect(response).to match_response_schema("user")
    end
  end
end
