class AddBankDetailsAndPayoutsEnabledToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :payouts_enabled, :boolean, default: false
  end
end
