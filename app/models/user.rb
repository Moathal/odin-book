class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts
  
  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.avatar_url = auth.info.image
      user.skip_confirmation!
      user.email_user_for_password_setting
    end
  end

  def email_user_for_password_setting
    puts "MAILER METHOD IS CALLED"
    if self.provider.present?
      puts "IF STATEMENT IS PASSED"
      token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
      self.reset_password_token = hashed_token
      self.reset_password_sent_at = Time.now.utc
      self.save
      UserMailer.set_a_password(self, token).deliver_now
    end
  end
end
