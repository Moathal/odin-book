class CreateNotifySubscribtions < ActiveRecord::Migration[7.1]
  def change
    create_table :notify_subscribtions do |t|
      t.string :endpoint
      t.string :auth_key
      t.string :p256dh_key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
