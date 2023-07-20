class AddDefaultValueToEmailConfirmed < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :email_confirmed, :boolean, default: false
  end

  def down
    change_column :users, :email_confirmed, :boolean, default: nil
  end
end
