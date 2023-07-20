class AddCareToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscriptions, :care, foreign_key: true
  end
end
