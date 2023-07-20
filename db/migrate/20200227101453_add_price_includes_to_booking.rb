class AddPriceIncludesToBooking < ActiveRecord::Migration[5.2]
  def change
  	add_column :bookings, :price_includes, :text
  end
end
