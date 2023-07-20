require 'rails_helper'

RSpec.describe "subscriptions/show", type: :view do
  before(:each) do
    @subscription = assign(:subscription, Subscription.create!(
      :user_id => 2,
      :subscriptionId => "Subscription",
      :planId => "Plan",
      :care_id => 3,
      :payment_intent => "Payment Intent",
      :status => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Subscription/)
    expect(rendered).to match(/Plan/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Payment Intent/)
    expect(rendered).to match(/4/)
  end
end
