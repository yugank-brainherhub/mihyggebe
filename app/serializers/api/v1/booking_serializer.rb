# frozen_string_literal: true

module API
  module V1
    class BookingSerializer
      include FastJsonapi::ObjectSerializer
      set_type :bookings
      attributes :id,
                 :first_name,
                 :last_name,
                 :email,
                 :mobile,
                 :checkin,
                 :checkout,
                 :no_of_guests,
                 :doc_received,
                 :bookingID,
                 :status,
                 :price_includes,
                 :price_per_bed,
                 :other_relation
      attribute :arrival_time do |object, _params|
        object.arrival_time&.strftime("%I:%M%p")
      end

      attribute :booked_by do |object, _params|
        user = object.user
        { id: object.user_id,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email,
          mobile: user.mobile 
        }
      end

      attribute :care_details do |object, _params|
        care = object.care
        beds = object.beds
        asset = care.assets.where('asset_type ILIKE (?)', '%image%').order('sort ASC').first
        url = asset.file&.service_url if asset&.file&.attachment
        tax = object.calculate_percent(object.price_per_bed, TAXES.fetch(care.state.upcase.to_sym))
        { id: object.care_id,
          name: care.name,
          address1: care.address1,
          address2: care.address2,
          state: care.state,
          city: care.city,
          category: care.category,
          approx_distance: care.approx_distance,
          map_url: care.map_url,
          room_type: beds.first&.room&.room_type,
          room_name: beds.first&.room&.name,
          bed_details: beds.map { |bed| BedSerializer.new(bed) },
          no_of_beds: beds.count,
          taxes_per_day: tax,
          image_url: url,
          cancelable?: Time.current <= object.created_at + 15.days,
        }
      end

      attribute :booking_for do |object, _params|
        {
          id: object.relationships.pluck(:id),
          name: object.relationships.pluck(:name)
        }
      end

      attribute :refc do |object, _params|
        assets = object.assets
        flag = false
        file_url = (assets.last.file.service_url if assets.present?)
        if assets.present? && assets.last.present? && assets.last.file.present?
          flag = true
        end  
        { 
          refc_flag: flag,
          refc_form: file_url
        }
      end

    end
  end
end
