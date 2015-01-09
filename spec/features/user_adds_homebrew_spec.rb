require "rails_helper"

feature "User adds a homebrew", %Q{
  As an authenticated user
  I want to add a homebrew
  So that my friends can give me feedback
  } do

  # Acceptance Criteria:
  # - [x] I must be logged in to add a homebrew
  # - [x] I must provide a name.
  # - [x] I must provide a date the batch was completed.
  # - [x] The date brewed must not be in the future.
  # - [x] The combination of name and date must be unique.
  # - [x] If the name/date combination are not unique, I receive an error message.
  # - [x] I can optionally provide a description.
  # - [x] If I do not provide all of the required fields, I receive an error message.

  context "authenticated user" do
    before :each do
      @user = FactoryGirl.create(:user)
      @beer = FactoryGirl.build(:homebrew)

      login_as(@user)
      click_on "Add a homebrew"
    end

    scenario "with required attributes" do
      fill_in "Name", with: @beer.name
      select @beer.year_brewed, from: "homebrew_date_brewed_1i"
      select @beer.month_brewed, from: "homebrew_date_brewed_2i"
      select @beer.date_brewed.day, from: "homebrew_date_brewed_3i"
      fill_in "Description", with: @beer.description
      click_on "Add my beer!"

      expect(page).to have_content "Thanks! Your beer has been added."
      expect(page).to have_content @beer.name
      expect(page).to have_content @beer.description
    end

    scenario "with missing attributes" do
      click_on "Add my beer!"

      expect(page).to have_content "Oops! Your beer could not be saved."
      expect(page).to have_content "Namecan't be blank"
      within ".homebrew_date_brewed" do
        expect(page).to have_content "can't be blank"
      end
    end

    scenario "adds the same beer" do
      @beer.save

      fill_in "Name", with: @beer.name
      select @beer.year_brewed, from: "homebrew_date_brewed_1i"
      select @beer.month_brewed, from: "homebrew_date_brewed_2i"
      select @beer.date_brewed.day, from: "homebrew_date_brewed_3i"
      fill_in "Description", with: @beer.description
      click_on "Add my beer!"

      expect(page).to have_content "Oops! Your beer could not be saved."
      expect(page).to have_content "You already added this beer."
    end
  end

  context "unauthenticated user" do
    scenario "link to add a homebrew not displayed" do
      visit "/"

      expect(page).to_not have_content "Add a homebrew"
    end

    scenario "cannot visit new homebrew form" do
      visit new_homebrew_path

      expect(page).to have_content "You need to sign in or sign up before continuing."
      expect(page).to_not have_content "Add my beer!"
    end
  end
end
