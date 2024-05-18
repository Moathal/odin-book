class FollowsController < ApplicationController

  # GET /follows or /follows.json
  def index
    user = User.find(params[:user_id])
    @followers = user.followers
    @followees = user.followees
    @freinds = user.friends
  end

  # POST /follows or /follows.json
  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
      if @follow.save
        FollowFriendshipNotifier.with(record: @follow, type: 'follow').deliver(@follow.followee)
        format.html { redirect_to user_url(@follow.followee), notice: "Follow was successfully created." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1 or /follows/1.json
  def destroy
    @follow = Follow.find_by(follow_params)
    @user = @follow.followee
    friendshipRec1 = Friendship.find_by(user_id: @follow.follower_id, friend_id: @follow.followee_id)
    friendshipRec2 = Friendship.find_by(user_id: @follow.followee_id, friend_id: @follow.follower_id)
    @follow.destroy!
    friendshipRec1.destroy!
    friendshipRec2.destroy!

    respond_to do |format|
      format.html { redirect_to user_path(@user) }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:follower_id, :followee_id)
    end
end
