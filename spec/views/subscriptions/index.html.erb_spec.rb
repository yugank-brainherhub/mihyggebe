require 'rails_helper'

RSpec.describe "subscriptions/index", type: :view do
  before(:each) do
    assign(:subscriptions, [
      Subscription.create!(
        :user_id => 2,
        :subscriptionId => "Subscription",
        :planId => "Plan",
        :care_id => 3,
        :payment_intent => "Payment Intent",
        :status => 4
      ),
      Subscription.create!(
        :user_id => 2,
        :subscriptionId => "Subscription",
        :planId => "Plan",
        :care_id => 3,
        :payment_intent => "Payment Intent",
        :status => 4
      )
    ])
  end

  it "renders a list of subscriptions" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Subscription".to_s, :count => 2
    assert_select "tr>td", :text => "Plan".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Payment Intent".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
