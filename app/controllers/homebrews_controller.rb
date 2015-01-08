class HomebrewsController < ApplicationController
  def index
  end
  def new
    @homebrew = Homebrew.new
  end

  def create
    @homebrew = current_user.homebrews.build(homebrew_params)

    if @homebrew.save
      redirect_to @homebrew, notice: "Thanks! Your beer has been added."
    end
  end

  private

  def homebrew_params
    params.require(:homebrew).permit(:name, :date_brewed, :description)
  end
end
