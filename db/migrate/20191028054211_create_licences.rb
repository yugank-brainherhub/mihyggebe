class CreateLicences < ActiveRecord::Migration[5.2]
  def change
    create_table :licences do |t|
      t.integer :licence_type
      t.references(:care, index: true)
      t.timestamps
    end
  end
end
