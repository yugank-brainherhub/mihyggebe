class CreateSubscriptionRefunds < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_refunds do |t|
      t.references :subscription, index: true
      t.string :refundId
      t.string :description
      t.string :status
      t.timestamps
    end
  end
end
