class AddColumnOtherRelationsToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :other_relation, :string, array: true, default: []
  end
end
