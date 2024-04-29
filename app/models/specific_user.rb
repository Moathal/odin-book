class SpecificUser < ApplicationRecord
  belongs_to :user
  belongs_to :specificable, polymorphic: true
end

# # Add a specific user to a post
# post.users << user

# # Remove a specific user from a post
# post.users.delete(user)
