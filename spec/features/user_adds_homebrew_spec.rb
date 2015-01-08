require "rails_helper"

feature "User adds a homebrew", %Q{
  As an authenticated user
  I want to add a homebrew
  So that my friends can give me feedback
  } do

    # Acceptance Criteria:
    # - [ ] I must be logged in to add a homebrew
    # - [ ] I must provide a name.
    # - [ ] I must provide a date the batch was completed.
    # - [ ] The combination of name and date must be unique.
    # - [ ] If the name/date combination are not unique, I recieve an error message.
    # - [ ] I can optionally provide a description.
    # - [ ] If I do not provide all of the required fields, I receive an error message.

    context "authenticated user" do
      before :each do
        @user = FactoryGirl.build_stubbed(:user)
        @beer = FactoryGirl.build(:homebrew)

        login_as(@user)
        click_on "Add a homebrew"
      end

      scenario "with required attributes" do
        save_and_open_page
        fill_in "Name", with: @beer.name
        choose @beer.year_brewed, from: "year"
        choose @beer.month_brewed, from: "month"
        choose @beer.day_brewed, from: "day"
        click_on "Add my beer!"

        expect(page).to have_content "Thanks! Your beer has been added."
        expect(page).to have_content @beer.name
        expect(page).to have_content @beer.description
      end

      scenario "with missing attributes"

      scenario "adds the same beer"
    end

    context "unauthenticated user" do
      scenario "cannot add a homebrew" do
        visit "/"

        expect(page).to_not have_content "Add a homebrew"
      end
    end
  end