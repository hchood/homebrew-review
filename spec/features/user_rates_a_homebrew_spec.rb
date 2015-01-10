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
    before :each do
      @homebrew = FactoryGirl.create(:homebrew)
      @user = FactoryGirl.create(:user)
      @review = FactoryGirl.build(:review,
        homebrew: @homebrew, reviewer: @user)

      login_as(@user)
    end

    context "friends with brewer" do
      before :each do
        friendship = FactoryGirl.create(:friendship,
          user: @homebrew.user,
          friend: @user
        )
      end

      scenario "successfully adds a review" do
        visit homebrew_path(@homebrew)

        select @review.rating, from: "Rating"
        fill_in "Comments", with: @review.body
        click_on "Submit"

        expect(page).to have_content "Your review has been added."
        expect(page).to have_content @review.body
      end

      scenario "with missing attributes" do
        visit homebrew_path(@homebrew)
        click_on "Submit"

        expect(page).to have_content "Your review could not be saved."
        expect(page).to have_content "can't be blank"
      end

      scenario "already reviewed homebrew" do
        @review.save
        visit homebrew_path(@homebrew)

        expect(page).to_not have_content "Review this beer:"
      end
    end

    scenario "not friends with brewer" do
      visit homebrew_path(@homebrew)

      expect(page).to_not have_content "Review this beer:"
    end
  end

  context "unauthenticated user" do
    scenario "does not see form on homebrew page" do
      homebrew = FactoryGirl.create(:homebrew)
      visit homebrew_path(homebrew)

      expect(page).to_not have_content "Review this beer:"
    end
  end
end
