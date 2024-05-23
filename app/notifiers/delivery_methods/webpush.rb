class DeliveryMethods::Webpush < ApplicationDeliveryMethod
  # Specify the config options your delivery method requires in its config block
  # required_options # :foo, :bar

  def deliver
    unless recipient.notifySubscription.nil?
      recipient.notifySubscription.push(notification)
    end
  end
end
