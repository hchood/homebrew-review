class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @homebrew = Homebrew.find(params[:homebrew_id])
    @review = @homebrew.reviews.build(review_params)
    @review.reviewer = current_user

    if @review.save
      redirect_to @homebrew, notice: "Your review has been added."
    else
      flash.now[:notice] = "Your review could not be saved."
      render "homebrews/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
