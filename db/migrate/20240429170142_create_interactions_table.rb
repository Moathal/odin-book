class CreateInteractionsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :interactions_tables do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :shares_num, default: 0
      t.integer :likes_num, default: 0
      t.integer :dislikes_num, default: 0
      t.integer :comments_num, default: 0
      t.integer :threads_num, default: 0
      t.integer :interactions_num, default: 0

      t.timestamps
    end
  end
end
