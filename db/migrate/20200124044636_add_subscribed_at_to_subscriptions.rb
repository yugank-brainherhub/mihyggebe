class AddSubscribedAtToSubscriptions < ActiveRecord::Migration[5.2]
  def change
  	add_column :subscriptions, :subscribed_at, :datetime
  end
end
