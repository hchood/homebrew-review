class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])

    if @friendship.save
      redirect_to users_path, notice: "Friend added!"
    else
      redirect_to users_path, notice: "Friend could not be added."
    end
  end

  def destroy

  end
end
