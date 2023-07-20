# frozen_string_literal: true

class API::V1::CarePolicy < API::V1::ApplicationPolicy
  def create?
    user.provider? || user.admin?
  end

  def update?
    user.admin? || (record.user == user && user.provider?)
  end

  def show?
    true
  end
end
