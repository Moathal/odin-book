class CreateFriendships < ActiveRecord::Migration[7.1]
  def change
    create_table :friendships do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.integer :type1
      t.integer :type2

      t.timestamps
    end
  end
end
