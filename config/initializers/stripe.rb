#frozen_string_literal: true

Rails.configuration.stripe = {
  publishable_key: 'pk_test_EAHDPRQu7NG78WxmqqLMIguB', #SECRETS[:publishable_key],
  secret_key: 'sk_test_gwknR1SsglZC1wn90LMZEO04' #SECRETS[:secret_key]
}

Stripe.api_key = 'sk_test_gwknR1SsglZC1wn90LMZEO04' #SECRETS[:secret_key]
Stripe.api_version = "2019-02-19"
