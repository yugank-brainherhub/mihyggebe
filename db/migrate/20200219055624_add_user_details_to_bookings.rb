class AddUserDetailsToBookings < ActiveRecord::Migration[5.2]
  def change
  	add_column :bookings, :first_name, :string
  	add_column :bookings, :last_name, :string
  	add_column :bookings, :email, :string
  	add_column :bookings, :mobile, :string
  	add_column :bookings, :user_id, :integer, index: true
  	add_column :bookings, :relationship_id, :integer, index: true
  	add_column :bookings, :bookingID, :string, index: true
  end
end
