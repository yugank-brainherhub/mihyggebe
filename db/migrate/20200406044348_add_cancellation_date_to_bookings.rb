class AddCancellationDateToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :cancelled_at, :date
  end
end
