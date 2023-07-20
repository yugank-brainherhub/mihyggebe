class CreateSelectedRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :selected_rooms do |t|
      t.references(:care, index: true)
      t.references(:room_type, index: true)
      t.timestamps
    end
  end
end
