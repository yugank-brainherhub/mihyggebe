# frozen_string_literal: true

class API::V1::RoomServiceTypePolicy < API::V1::ApplicationPolicy
  def index?
    true
  end
end
