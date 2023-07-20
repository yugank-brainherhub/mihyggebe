class CreateSelectedFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :selected_facilities do |t|
      t.references(:care, index: true)
      t.references(:facility, index: true)
      t.references(:facility_type, index: true)
      t.timestamps
    end
  end
end
