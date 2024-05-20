class ReactionsController < ApplicationController
  before_action :set_reaction, only: [:destroy]
  
  def create
    @reaction = Reaction.new(reaction_params)
    if @reaction.save
      InteractionNotifier.with(record: @reaction).deliver_later(@reaction.post.user)
    else
      flash[:error] = "Failed to react to the post"
    end
  end
  
  def destroy
    if @reaction.destroy
      # handle successful deletion
    else
      flash[:error] = "Failed to delete the reaction"
    end
  end
  
  private
  
  def set_reaction
    @reaction = Reaction.find(params[:id])
  end
  
  def reaction_params
    params.require(:reaction).permit(:user_id, :post_id, :reaction)
  end
end
