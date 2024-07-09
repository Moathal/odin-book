class Reaction < ApplicationRecord
  belongs_to :post
  belongs_to :user
  before_save :update_interactions

  enum :reaction, { dislike: -1, like: 0, love: 1, haha: 2, wow: 3, sad: 4, angry: 5}

  scope :likes, -> { where(reaction: :like) }
  scope :loves, -> { where(reaction: :love) }
  scope :hahas, -> { where(reaction: :haha) }
  scope :wows, -> { where(reaction: :wow) }
  scope :sads, -> { where(reaction: :sad) }
  scope :angrys, -> { where(reaction: :angry) }
  scope :dislikes, -> { where(reaction: :dislike) }

  def update_interactions
    if ['create', 'update'].include? action
      reaction >= 0 ? post.interactions.increment(:likes_num).save : post.interactions.increment(:dislikes_num).save
    else
      reaction >= 0 ? post.interactions.decrement(:likes_num).save : post.interactions.decrement(:dislikes_num).save
    end
  end
end
