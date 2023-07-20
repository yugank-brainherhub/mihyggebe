class AddPaymentIntentToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :payment_intent, :string
  end
end
