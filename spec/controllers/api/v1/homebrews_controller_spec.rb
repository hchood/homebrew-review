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

      get :index, {}, { "Accept" => "application/vnd.mycompany.com; version=1" }

      expect(response.status).to eq 200
      expect(response).to match_response_schema("homebrews")
    end
  end

  describe "Fetching a homebrew" do
    it "returns a single homebrew" do
      homebrew = FactoryGirl.create(:homebrew)

      get :show, { id: homebrew.id }, {  "Accept" => "application/vnd.mycompany.com; version=1" }

      expect(response.status).to eq 200
      expect(response).to match_response_schema("homebrew")
    end
  end

  describe "Creating a homebrew" do
    context "with valid access token" do
      let(:api_key) { FactoryGirl.create(:api_key) }
      let(:current_user) { api_key.user }

      before do
        mock_authentication_with(api_key)
      end

      context "with valid attributes" do
        it "creates a new homebrew" do
          tags = FactoryGirl.create_list(:tag, 2)
          homebrew_attributes = FactoryGirl.attributes_for(:homebrew)
          homebrew_attributes.merge!(tag_ids: [tags.first.id, tags.last.id])
          expect(Homebrew.count).to eq 0

          post :create, homebrew: homebrew_attributes

          expect(Homebrew.count).to eq 1
          expect(Homebrew.first.tags.count).to eq 2
          expect(response.status).to eq 201
          expect(response).to match_response_schema("homebrew")
        end
      end

      context "with invalid attributes" do
        it "is not successful" do
          post :create, homebrew: { invalid: "" }

          expect(response.status).to eq 422
          expect(response.body).to include "can't be blank"
        end
      end
    end

    it "requires a valid access token" do
      post :create, homebrew: { name: "Extra Hoppy IPA" }

      expect(response.status).to eq 401
      expect(response.body).to include "Bad credentials"
    end
  end

  describe "Updating a homebrew" do
    context "with access token" do
      let(:api_key) { FactoryGirl.create(:api_key) }
      let(:current_user) { api_key.user }

      before do
        mock_authentication_with(api_key)
      end

      context "with brewer's access token" do
        let!(:homebrew) { FactoryGirl.create(:homebrew, brewer: current_user) }

        context "with valid attributes" do
          it "updates the homebrew" do
            expect {
              put :update, id: homebrew.id, homebrew: { description: "Best beer ever." }
            }.to_not change { Homebrew.count }

            homebrew.reload

            expect(response.status).to eq 200
            expect(response).to match_response_schema("homebrew")
            expect(homebrew.description).to eq "Best beer ever."
          end
        end

        context "with invalid attributes" do
          it "is not successful" do
            put :update, id: homebrew.id, homebrew: { name: "" }

            expect(response.status).to eq 422
            expect(response.body).to include "can't be blank"
          end
        end
      end

      context "with different user's access token" do
        it "is unauthorized" do
          homebrew = FactoryGirl.create(:homebrew)

          put :update, id: homebrew.id, homebrew: { description: "Best beer ever." }

          expect(response.status).to eq 401
          expect(response.body).to include "Bad credentials"
        end
      end
    end

    context "without valid access token" do
      it "is unauthorized" do
        put :update, id: 'anything'

        expect(response.status).to eq 401
        expect(response.body).to include "Bad credentials"
      end
    end
  end
end
