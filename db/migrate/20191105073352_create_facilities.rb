class CreateFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities do |t|
      t.string :name, index: true
      t.references(:facility_type, index: true)
      t.timestamps
    end
  end
end
