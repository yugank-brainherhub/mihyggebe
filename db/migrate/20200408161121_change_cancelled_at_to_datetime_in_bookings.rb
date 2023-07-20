class ChangeCancelledAtToDatetimeInBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :cancelled_at, :datetime
  end
end
