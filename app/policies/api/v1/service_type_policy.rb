# frozen_string_literal: true

class API::V1::ServiceTypePolicy < API::V1::ApplicationPolicy
  def index?
    true
  end
end
