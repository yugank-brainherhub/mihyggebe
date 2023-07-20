class CreateRoomServiceTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :room_service_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
