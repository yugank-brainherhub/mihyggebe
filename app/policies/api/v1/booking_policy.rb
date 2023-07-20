# frozen_string_literal: true

class API::V1::BookingPolicy < API::V1::ApplicationPolicy
  def show?
    record.user == user || user == record.care.user
  end

  def update?
    user.admin? || record.user == user || user == record.care.user
  end
end
