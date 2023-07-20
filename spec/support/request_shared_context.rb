# frozen_string_literal: true
include JsonWebToken

shared_context 'api request' do
  let(:customer_role) { FactoryBot.create(:role, :as_customer) }
  let(:social_worker_role) { FactoryBot.create(:role, :as_social_worker) }
  let(:provider_role) { FactoryBot.create(:role, :as_provider) }
  let(:admin_role) { FactoryBot.create(:role, :as_amdin) }

  let(:admin) { FactoryBot.create(:user, role: admin_role ) }
  let(:admin_user) { admin }
  let(:admin_token)  { encode_token({ user_id: admin_user.id }, (Time.current + 15.minutes).to_i) }
  let(:admin_authorization) { "Bearer #{admin_token}" }

  let(:provider) { FactoryBot.create(:user, role: FactoryBot.create(:role, :as_provider) ) }
  let(:provider_user) { provider }
  let(:provider_token)  { encode_token({ user_id: provider_user.id }, (Time.current + 15.minutes).to_i) }
  let(:provider_authorization) { "Bearer #{provider_token}" }
  let(:senior_living) { FactoryBot.create(:care, :as_sl, user: provider_user) }
  let(:homeshare) { FactoryBot.create(:care, :as_homeshare, user: provider_user) }
 

  let(:customer) { FactoryBot.create(:user, role: FactoryBot.create(:role, :as_customer) ) }
  let(:customer_user) { customer }
  let(:customer_token)  { encode_token({ user_id: customer_user.id }, (Time.current + 15.minutes).to_i) }
  let(:customer_authorization) { "Bearer #{customer_token}" }
end
