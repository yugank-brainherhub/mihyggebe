# frozen_string_literal: true

class API::V1::AssetPolicy < API::V1::ApplicationPolicy
  def create?
    user.provider? || user.admin?
  end

  def update?
    user.provider? || user.admin?
  end

  def destroy?
    user.provider? || user.admin?
  end
end
