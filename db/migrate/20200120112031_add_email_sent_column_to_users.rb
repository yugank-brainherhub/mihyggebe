class AddEmailSentColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_sent, :boolean, default: false
  end
end
