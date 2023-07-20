class AddPricePerBedToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :price_per_bed, :float, default: 0.0
  end
end
