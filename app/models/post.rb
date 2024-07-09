class Post < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_rich_text :text
  has_many :comments, dependent: :destroy
  has_one :interaction, dependent: :destroy
  has_many :reactions, dependent: :destroy

  belongs_to :parent, class_name: 'Post', optional: true
  has_many :threads, class_name: 'Post', foreign_key: :parent_id, dependent: :destroy

  has_many :specific_users, as: :specificable
  has_many :users, through: :specific_users

  has_many :shared_users, through: :shares, source: :user

  enum privacy_setting: { onlyme: 0 , everyone: 1, followers: 2, followees: 3, specific_users: 4, friends: 5, close_friends: 6, family: 7, other: 8 }

  def depth
    parent ? parent.depth + 1 : 0
  end
end
