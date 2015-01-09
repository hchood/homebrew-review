require "rails_helper"

feature "User friends another user", %Q{
  As an authenticated user
  I want to friend another user
  So that I can rate their homebrews
  } do

  # Acceptance Criteria:
  # - [ ] I must be logged in to friend a user.
  # - [ ] I can friend a user from the users index page or a user's show page.
  # - [ ] I cannot friend a user more than once.
  # - [ ] I cannot friend myself.

  context "authenticated user" do
    before :each do
      @user = FactoryGirl.create(:user)
      @friend = FactoryGirl.create(:user)

      login_as(@user)
    end

    context "not yet friends" do
      scenario "from users index page" do
        visit users_path
        click_on "Add friend"

        expect(page).to have_content "Friend added!"
        expect(page).to_not have_button "Add friend"
        expect(page).to have_button "Remove friend"
      end

      scenario "from user's profile page" do
        visit user_path(@friend)
        click_on "Add friend"

        expect(page).to have_content "Friend added!"
        expect(page).to_not have_button "Add friend"
        expect(page).to have_button "Remove friend"
      end
    end

    context "already friends" do
      before :each do
        FactoryGirl.create(:friendship, user: @user, friend: @friend)
      end

      scenario "no button on index page" do
        visit users_path

        expect(page).to_not have_button "Add friend"
        expect(page).to have_button "Remove friend"
      end

      scenario "no button on user profile page" do
        visit user_path(@friend)

        expect(page).to_not have_button "Add friend"
        expect(page).to have_button "Remove friend"
      end
    end
  end

  context "unauthenticated user" do
    scenario "cannot access user index page" do
      visit users_path

      expect(page).to have_content "You need to sign in or sign up before continuing."
      expect(page).to_not have_content "All users"
    end

    scenario "cannot access user profile page" do
      user = FactoryGirl.create(:user)
      visit user_path(user)

      expect(page).to have_content "You need to sign in or sign up before continuing."
      expect(page).to_not have_content user.full_name
    end
  end
end
