class CreateStaffRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_roles do |t|
      t.string :name
      t.timestamps
    end
  end
end
