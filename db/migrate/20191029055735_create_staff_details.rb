class CreateStaffDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_details do |t|
      t.string :name
      t.references(:care, index: true)
      t.references(:staff_role, index: true)
      t.timestamps
    end
  end
end
