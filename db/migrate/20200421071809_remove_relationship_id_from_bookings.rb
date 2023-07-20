class RemoveRelationshipIdFromBookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :relationship_id, index: true
  end
end
