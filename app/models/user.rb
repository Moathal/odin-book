class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2, :twitter]

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.avatar_url = auth.info.image
      user.skip_confirmation!
    end
  end

  def email_user_for_password_setting
    if user.persisted? && user.provider.present? && user.encrypted_password.blank?
      token = Devise.token_generator.generate(User, :reset_password_token)
      user.reset_password_token = token
      user.reset_password_sent_at = Time.now.utc
      user.save

      UserMailer.set_a_password(user, token).deliver_now
    end
    user
  end
end
