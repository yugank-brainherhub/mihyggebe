class AddCheckrStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :checkr_status, :integer, default: 0
  end
end
