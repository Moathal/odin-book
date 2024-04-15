class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :text
end
