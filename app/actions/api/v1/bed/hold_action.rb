# frozen_string_literal: true

module API
  module V1
    class Bed::HoldAction < Bed::BaseAction
      include Actions::Pagination
      def perform
        @success = block_beds
      end

      def data
        { msg: I18n.t('bed.blocked') }
      end

      def block_beds
        bed_ids = $redis.get("blocked_beds").present? ? $redis.get("blocked_beds")&.split(',') + params[:bed_ids] : params[:bed_ids]
        $redis.set("blocked_beds", bed_ids.join(','))
        ClearbedsJob.set(wait: 10.minutes).perform_later(params[:bed_ids])
        return true
      end

      def authorize!
        true
      end
    end
  end
end
