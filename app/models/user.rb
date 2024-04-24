class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  has_many :specific_users
  has_many :specificable_posts, through: :specific_users, source: :specificable, source_type: 'Post'

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users, source: :followee

  has_many :follower_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :follower_users, source: :follower

  enum posts_privacy_setting: { everyone: 0, followers: 1, followees: 2, specific_users: 3, friends: 4, close_friends: 5, family: 6, other: 7 }
  enum profile_privacy_setting: { everyone: 0, followers: 1, followees: 2, specific_users: 3, friends: 4, close_friends: 5, family: 6, other: 7 }
  
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

  def attach_avatar_from_url(url)
    return unless url

    file = URI.open(url)
    avatar.attach(io: file, filename: File.basename(URI.parse(url).path))
  end

  def following?(other_user)
    followees.include?(other_user)
  end
end
