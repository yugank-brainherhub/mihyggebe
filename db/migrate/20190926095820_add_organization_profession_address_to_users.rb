class AddOrganizationProfessionAddressToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :organization, :string
    add_column :users, :address, :text
    add_column :users, :profession, :string
  end
end
