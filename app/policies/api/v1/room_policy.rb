# frozen_string_literal: true

class API::V1::RoomPolicy < API::V1::ApplicationPolicy
  def create?
    user.provider? || user.admin?
  end

  def show?
    true
  end

  def update?
    user.admin? || (record.care.user == user && user.provider?)
  end

  def destroy?
  	(record.care.user == user && user.provider?)
  end
end
