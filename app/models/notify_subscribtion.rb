class NotifySubscribtion < ApplicationRecord
  belongs_to user

  def push(notification)
    message = {
      title: notification.title_message,
      body: notification.body_message,
      url: notification.url,
      type: notification.type
    }.to_json
    
    Webpush.payload_send(
      message: message,
      endpoint: endpoint,
      p256dh: p256dh_key,
      auth: auth_key,
      vapid: {
        public_key: Rails.application.credentials.dig[:webpush, :public_key],
        private_key: Rails.application.credentials.dig[:webpush, :private_key]
      }
    )
  end
end
