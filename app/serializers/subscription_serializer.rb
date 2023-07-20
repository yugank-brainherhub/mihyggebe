class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :subscriptionId, :planId, :care_id, :payment_intent, :subscribed_at, :status
end
