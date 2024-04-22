class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ destroy ]

  # GET /follows or /follows.json
  def index
    user = User.find(params[:user_id])
    @followers = user.followers
    @followees = user.followees
    @freinds = user.friends
  end

  # GET /follows/new
  def new
    @follow = Follow.new
  end

  # POST /follows or /follows.json
  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
      if @follow.save
        format.html { redirect_to follow_url(@follow), notice: "Follow was successfully created." }
        format.json { render :show, status: :created, location: @follow }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1 or /follows/1.json
  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy!

    respond_to do |format|
      format.html { redirect_to follows_url, notice: "Follow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:follower_id, :followed_id)
    end
end
