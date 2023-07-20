class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :room_type
      t.integer :bathroom_type
      t.float :price
      t.datetime :available_from
      t.datetime :available_to
      t.text :price_desc
      t.integer :roomID
      t.references(:care, index: true)
      t.timestamps
    end
  end
end
