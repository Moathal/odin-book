class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  enum type: { close_friend: 0, family: 1, other: 2 }
end
