require "rails_helper"

feature "User views a user's profile", %Q{
  As an authenticated user
  I want to view a user's profile
  So that I can see their activity
  } do

  # Acceptance Criteria:
  # - [x] I must be authenticated to view a user's profile page
  # - [x] The user's first name and last name are displayed.
  # - [x] Links to each of the user's homebrews are displayed.
  # - [x] If the user has not added any homebrews yet, a message to that effect is displayed.
  # - [ ] Links to each of the user's friends are displayed.
  # - [ ] If the user doesn't have any friends yet, a message to that effect is displayed.

  context "authenticated user" do
    before :each do
      @user = FactoryGirl.create(:user)
      login_as(@user)
    end

    scenario "user has added homebrews and has friends" do
      beers = FactoryGirl.create_list(:homebrew, 3, user: @user)
      friendships = FactoryGirl.create_list(:friendship, 2, user: @user)

      visit user_path(@user)

      expect(page).to have_content @user.first_name
      expect(page).to have_content @user.last_name

      @user.all_friends.each do |friend|
        expect(page).to have_link friend.full_name
      end

      beers.each do |beer|
        expect(page).to have_link beer.name
      end
    end

    scenario "user hasn't added any homebrews or friends" do
      visit user_path(@user)

      expect(page).to have_content @user.first_name
      expect(page).to have_content @user.last_name
      expect(page).to have_content "#{@user.first_name} hasn't added any homebrews yet."
      expect(page).to have_content "#{@user.first_name} hasn't made any friends yet."
    end
  end

  context "unauthenticated user" do
    scenario "cannot visit profile page" do
      user = FactoryGirl.create(:user)
      visit user_path(user)

      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end
end
