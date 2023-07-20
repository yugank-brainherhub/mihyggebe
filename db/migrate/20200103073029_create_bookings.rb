class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.datetime :checkin
      t.datetime :checkout
      t.datetime :arrival_time
      t.integer :no_of_guests
      t.boolean :doc_received
      t.integer :status
      t.references(:care, index: true)
      t.timestamps
    end
  end
end
