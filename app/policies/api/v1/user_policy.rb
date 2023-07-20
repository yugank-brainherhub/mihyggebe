# frozen_string_literal: true

class API::V1::UserPolicy < API::V1::ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def update?
    record.id == user.id
  end

  def destroy?
  	true
  end
end
