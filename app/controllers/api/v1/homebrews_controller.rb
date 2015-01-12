class API::V1::HomebrewsController < ApplicationController
  def index
    @homebrews = Homebrew.all
  end

  def show
    @homebrew = Homebrew.find(params[:id])
  end
end
