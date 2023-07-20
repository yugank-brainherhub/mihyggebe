class CreateRoomServices < ActiveRecord::Migration[5.2]
  def change
    create_table :room_services do |t|
      t.string :name, index: true
      t.references(:room_service_type, index: true)
      t.timestamps
    end
  end
end
