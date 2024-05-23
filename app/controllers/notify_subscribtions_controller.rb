class NotifySubscribtionsController < ApplicationController
  def create
    notifySubscription = WebNotifications.find_by(auth_key: params[:keys][:auth])
    notifySubscription = WebNotifications.new(
      user: current_user,
      endpoint: params[:endpoint],
      auth_key: params[:keys][:auth],
      p256dh_key: params[:keys][:p256dh],
    ) unless notifySubscription

    if notifySubscription.save
      render json: notifySubscription
    else
      render json: notifySubscription.errors.full_messages
    end
  end
end
