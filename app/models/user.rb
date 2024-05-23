class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  include FriendshipAssociations

  include FollowAssociations
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :shared_posts, through: :shares, source: :post
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  
  has_many :specific_users
  has_many :specificable_posts, through: :specific_users, source: :specificable, source_type: 'Post'
  
  has_many :blocks, foreign_key: :blocker_id
  has_many :blocked_users, through: :blocks, source: :blockee
  
  enum posts_privacy_setting: { posts_onlyme: 0 , posts_everyone: 1, posts_followers: 2, posts_followees: 3, posts_specific_users: 4, posts_friends: 5, posts_close_friends: 6, posts_family: 7, posts_other: 8 }
  enum profile_privacy_setting: { profile_onlyme: 0, profile_everyone: 1, profile_followers: 2, profile_followees: 3, profile_specific_users: 4, profile_friends: 5, profile_close_friends: 6, profile_family: 7, profile_other: 8 }
  
  has_many :notifications, class_name: 'Noticed:Model', as: :recipient

  has_many :notifySubscribtions
  
  include UserMethods
end
