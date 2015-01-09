require "rails_helper"

feature "User unfriends another user", %Q{
  As an authenticated user
  I want to unfriend another user
  So that they can no longer review my beers
  } do

  # Acceptance Criteria:
  # - [x] I must be logged in to unfriend a user. [Not testing this - already testing they can't access users index & show pages]
  # - [x] I can unfriend a user from the users index page or a user's show page.
  # - [x] I can only unfriend a user that I'm already friends with. [Not testing this - testing that the buttons change is enough, I think]

  context "authenticated user" do
    before :each do
      friendship = FactoryGirl.create(:friendship)
      @user = friendship.user
      @friend = friendship.friend

      login_as(@user)
    end

    scenario "from users index page" do
      visit users_path
      click_on "Remove friend"

      expect(page).to have_content "Friend removed."
      expect(page).to have_button "Add friend"
      expect(page).to_not have_button "Remove friend"
    end

    scenario "from user profile page" do
      visit user_path(@friend)
      click_on "Remove friend"

      expect(page).to have_content "Friend removed."
      expect(page).to have_button "Add friend"
      expect(page).to_not have_button "Remove friend"
    end
  end
end
