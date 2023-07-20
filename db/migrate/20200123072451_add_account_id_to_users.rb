class AddAccountIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accountId, :string
  end
end
