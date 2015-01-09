class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.order(:last_name, :first_name).page(params[:page])
  end
end
