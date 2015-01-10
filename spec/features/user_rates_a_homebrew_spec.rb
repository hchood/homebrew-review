require "rails_helper"

feature "User reviews a homebrew", %Q{
  As an authenticated user
  I want to review a homebrew
  So that I can share my opinion with others
  } do

  # Acceptance Criteria:
  # - [ ] I must be logged in to rate a homebrew.
  # - [ ] I must be friends with the brewer, or be the brewer, to rate a homebrew.
  # - [ ] I can only rate a homebrew once.
  # - [ ] I must provide a rating between 1 and 5 stars.
  # - [ ] I can optionally provide a comment.


  context "authenticated user" do
    context "friends with brewer" do
      before :each do
        homebrew = FactoryGirl.create(:homebrew)
        @review = FactoryGirl.build(:review, homebrew: homebrew)
        friendship = FactoryGirl.create(:friendship, user: homebrew.user)
        @user = friendship.friend

        login_as(@user)
        visit homebrew_path(homebrew)
      end

      scenario "successfully adds a review" do
        select @review.rating, from: "Rating"
        fill_in "Comments", with: @review.body
        click_on "Submit"

        expect(page).to have_content "Your review has been added."
        expect(page).to have_content @review.body
      end

      scenario "with missing attributes" do
        click_on "Submit"

        expect(page).to have_content "Your review could not be saved."
        expect(page).to have_content "can't be blank"
      end

      scenario "already rated homebrew"
    end

    scenario "not friends with brewer"
  end

  context "unauthenticated user" do
    scenario "does not see form on homebrew page"
  end
end
