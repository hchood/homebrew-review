class HomebrewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @homebrews = Homebrew.order(date_brewed: :desc).page(params[:page])
  end

  def show
    @homebrew = Homebrew.find(params[:id])
    @review = @homebrew.reviews.build
  end

  def new
    @homebrew = Homebrew.new
  end

  def create
    @homebrew = current_user.homebrews.build(homebrew_params)

    if @homebrew.save
      params[:homebrew][:tag_ids].each do |tag_id|
        if !tag_id.blank?
          tagging = @homebrew.taggings.build(tag_id: tag_id)
          tagging.save
        end
      end

      redirect_to @homebrew, notice: "Thanks! Your beer has been added."
    else
      flash.now[:notice] =  "Oops! Your beer could not be saved."
      render :new
    end
  end

  private

  def homebrew_params
    params.require(:homebrew).permit(:name, :date_brewed, :description, tag_ids: [])
  end
end
