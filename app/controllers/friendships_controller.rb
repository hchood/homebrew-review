class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: "Friend added!"
    else
      redirect_to users_path, notice: "Friend could not be added."
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    if @friendship.destroy
      redirect_to users_path, notice: "Friend removed."
    else
      redirect_to users_path, notice: "Friend could not be removed."
    end
  end
end
