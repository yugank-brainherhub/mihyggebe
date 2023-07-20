class CreateCareDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :care_details do |t|
      t.text :description
      t.text :area_description
      t.integer :no_of_bedrooms
      t.integer :no_of_bathrooms
      t.integer :no_of_restrooms
      t.integer :no_of_rooms
      t.references(:care, index: true)
      t.timestamps
    end
  end
end
