require "rails_helper"

feature "User views list of homebrews", %Q{
    As a site visitor
    I view a list of homebrews
    So that I can see what people are brewing
  } do

  # Acceptance Criteria:
  # - [ ] I see a list of homebrews organized by date_brewed.
  # - [ ] The page displays 20 beers at a time.

  scenario "visits homebrews index page" do
    homebrews = FactoryGirl.create_list(:homebrew, 21)
    first_twenty_beers = homebrews[0...-1]

    visit homebrews_path

    first_twenty_beers.each do |beer|
      expect(page).to have_link beer.name
    end

    expect(page).to_not have_link homebrews.last.name
  end
end
