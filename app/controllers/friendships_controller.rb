class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action set_freindship:, only: [:edit, :update, :destroy]

  def create
    @friendship = Freindship.new(friendship_params)
    @friend = User.find(friendship_params[:friend_id])
    if @friendship.save
      flash[:notice] = "You are now a friend with #{@friend.fullname} of type #{@friendship.type}"
    else
      flash[:alert] = "There was an error adding/following new friend #{@friend.name}"
    end
  end

  def update
    if @friendship.update(friendship_params)
      flash[:notice] = "Friendship type updated successfully"
    else
      flash[:alert] = "Failed to update friendship type"
    end
  end

  def destroy
    user_id = @friendship.user_id
    if @friendship.destroy
      Friendship.find_by(user_id: @friendship.friend_id, friend_id: user_id).destroy
      flash[:notice] = "Friendship destroyed successfully"
    else
      flash[:alert] = "Failed to destroy friendship"
    end
  end

  private

  def set_freindship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:freindship).permit(:type)
  end
end
