class CreateSelectedRoomServices < ActiveRecord::Migration[5.2]
  def change
    create_table :selected_room_services do |t|
      t.references(:room, index: true)
      t.references(:room_service, index: true)
      t.references(:room_service_type, index: true)
      t.timestamps
    end
  end
end
