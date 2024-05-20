class SharesController < ApplicationController
  def create
    @share = Share.new(share_params)
    InteractionNotifier.with(record: @share).deliver_later(@share.post.user)
    if @share.save
      ShareNotifier.with(record: @share).deliver_later(@share.post.user)
    else
      flash[:error] = "Failed to share the post"
    end
  end

  def destroy
    @share = Share.find(params[:id])
    @share.destroy!
  end

  private

  def share_params
    params.require(:share).permit(:user_id, :post_id)
  end
end
