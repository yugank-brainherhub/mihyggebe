class AddInvitationStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :invitation_status, :string, default: ''
  end
end
