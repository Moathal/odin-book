class Share < ApplicationRecord
  belongs_to :user
  belongs_to :post
  before_save :update_interactions

  def update_interactions
    if action == 'create'
      post.interactions.increment(:shares_num).save
    else
      post.interactions.decrement(:shares_num).save
    end
  end
end
