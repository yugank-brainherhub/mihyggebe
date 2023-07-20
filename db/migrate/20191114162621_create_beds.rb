class CreateBeds < ActiveRecord::Migration[5.2]
  def change
    create_table :beds do |t|
      t.integer :bed_number
      t.integer :bed_type
      t.references(:room, index: true)
      t.references(:service, index: true)
      t.timestamps
    end
  end
end
