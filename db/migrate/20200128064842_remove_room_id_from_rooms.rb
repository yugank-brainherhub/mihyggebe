class RemoveRoomIdFromRooms < ActiveRecord::Migration[5.2]
  def change
  	remove_column :rooms, :roomID
  end
end
