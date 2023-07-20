class CreateBookingsRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings_relationships do |t|
      t.belongs_to :booking
      t.belongs_to :relationship
    end
  end
end
