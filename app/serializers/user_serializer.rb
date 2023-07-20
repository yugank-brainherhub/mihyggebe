class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :role_id, :mobile, :messenger, :stripeID, :above18, :organization, :address, :profession, :docusign_status, :status, :checker_paid_date, :checker_future_payment, :checkr_status, :accountId, :checkrId, :invitation_status
end
