# frozen_string_literal: true

module API
  module V1
    class Booking::CreateAction < Booking::BaseAction
      def data
        API::V1::BookingSerializer.new(record)
      end

      def perform
        @blocked_beds = ::Room.blocked_beds.collect(&:to_i)
        @selected_beds = permitted_params.dig('bed_bookings_attributes').values.map {|param| param.fetch(:bed_id) }

        if (@blocked_beds & @selected_beds).present?
          @success = false
          fail_with_error(422, self.class.record_type, { error: "Sorry, beds already booked!!!" })
        else
          @success = save_record!
        end
      end

      def save_record!
        if record.save
          beds = record.beds.ids

          bed_ids = ::Room.blocked_beds + beds
          $redis.set("blocked_beds", bed_ids.join(','))

          ClearbookingJob.set(wait: 10.minutes).perform_later(record.id)
          return true
        end
        raise record.errors.inspect
        fail_with_error(422, self.class.record_type, record.errors)
      end

      def record
        @record ||= self.class.record_class.new(permitted_params.merge(status: 'draft',
                                                                       price_per_bed: find_price_per_bed,
                                                                       other_relation: custom_relation))
      end

      def find_price_per_bed
        bed_id = permitted_params.dig('bed_bookings_attributes', '0', 'bed_id')
        ::Bed.find(bed_id).room.price
      end

      def custom_relation
        permitted_params[:other_relation].split(',')
      end

      def authorize!
        true
      end
    end
  end
end
