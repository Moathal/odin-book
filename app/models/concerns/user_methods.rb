module UserMethods
  extend ActiveSupport::Concern
  
  included do
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.first_name = auth.info.name
        user.attach_avatar_from_url(auth.info.image)
        user.skip_confirmation!
        user.email_user_for_password_setting
      end
    end

    def email_user_for_password_setting
      if self.provider.present?
        token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
        self.reset_password_token = hashed_token
        self.reset_password_sent_at = Time.now.utc
        self.save
        UserMailer.set_a_password(self, token).deliver_now
      end
    end

    def attach_avatar_from_url(url)
      return unless url

      file = URI.open(url)
      avatar.attach(io: file, filename: File.basename(URI.parse(url).path))
    end

    def full_name
      "#{first_name} #{last_name}"
    end

    def following?(other_user)
      followees.include?(other_user)
    end

    def all_posts
      (posts + shared_posts).uniq
    end
  end
end