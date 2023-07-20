# frozen_string_literal: true

module API
  module V1
    class RelationshipSerializer < BaseSerializer
      set_type :relationships

      attributes :id, :name
    end
  end
end
