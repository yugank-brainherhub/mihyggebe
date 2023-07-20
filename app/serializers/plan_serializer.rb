class PlanSerializer < ActiveModel::Serializer
  attributes :id, :min, :max, :planId, :price, :status
end
