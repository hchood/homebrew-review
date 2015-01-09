class HomebrewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
  end

  def show
    @homebrew = Homebrew.find(params[:id])
  end

  def new
    @homebrew = Homebrew.new
  end

  def create
    @homebrew = current_user.homebrews.build(homebrew_params)

    if @homebrew.save
      redirect_to @homebrew, notice: "Thanks! Your beer has been added."
    else
      flash.now[:notice] =  "Oops! Your beer could not be saved."
      render :new
    end
  end

  private

  def homebrew_params
    params.require(:homebrew).permit(:name, :date_brewed, :description)
  end
end
