# frozen_string_literal: true

class ClearbedsJob < ApplicationJob
  queue_as :default

  def perform(bed_ids)
    beds = $redis.get("blocked_ids").split(',') - bed_ids if $redis.get("blocked_ids").present?
    $redis.set("blocked_ids", beds&.join(','))
  end
end
