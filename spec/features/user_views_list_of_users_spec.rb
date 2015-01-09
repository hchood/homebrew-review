require "rails_helper"

feature "User views list of users", %Q{
  As an authenticated user
  I view a list of other users
  So that I can find my friends
  } do

    # Acceptance Criteria:
    # - [ ] I must be authenticated to view the users index page.
    # - [ ] I see a list of users organized alphabetically by last name, then first name.
    # - [ ] The page displays 20 users at a time.

  context "authenticated user" do
    scenario "visits users index page" do
      users = FactoryGirl.create_list(:user, 21)
      users.sort_by! { |user| [user.last_name, user.first_name] }

      first_twenty_users = users[0...-1]
      last_user = users.last

      login_as(users.first)
      visit users_path

      first_twenty_users.each do |user|
        expect(page).to have_link user.full_name
      end

      expect(page).to_not have_link last_user.full_name
    end
  end

  context "unauthenticated user" do
    scenario "cannot see link to users index page" do
      visit "/"

      expect(page).to_not have_link "Browse users"
    end

    scenario "cannot visit users index page" do
      visit users_path

      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end
end
