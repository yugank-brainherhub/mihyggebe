class CreateBedBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bed_bookings do |t|
      t.references(:bed, index: true)
      t.references(:booking, index: true)
      t.timestamps
    end
  end
end
