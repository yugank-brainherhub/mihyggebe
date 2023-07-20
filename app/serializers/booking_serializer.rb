class BookingSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :mobile, :user_id, :bookingID, :price_includes, :price_per_bed, :other_relation, :cancelled_at, :checkin, :checkout, :arrival_time, :no_of_guests, :doc_received, :status, :care_id
end
