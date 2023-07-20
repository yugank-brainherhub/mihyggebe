class AddDocusignStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :docusign_status, :string
  end
end
