class API::V1::HomebrewsController < ApplicationController
  def index
    @homebrews = Homebrew.all
  end
end
