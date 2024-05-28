class FcmDeviceTokensController < ApplicationController
  before_action :set_fcm_device_token, only: [:destroy]

  def create
    @fcm_device_token = FcmDeviceToken.new(fcm_device_token_params)

    if @fcm_device_token.save
      render json: @fcm_device_token, status: :created
    else
      render json: @fcm_device_token.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @fcm_device_token.destroy
  end

  private
  
  def set_fcm_device_token
    @fcm_device_token = FcmDeviceToken.find(params[:id])
  end

  def fcm_device_token_params
    params.require(:fcm_device_token).permit(:token)
  end
end