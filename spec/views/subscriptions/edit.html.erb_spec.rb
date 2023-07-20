require 'rails_helper'

RSpec.describe "subscriptions/edit", type: :view do
  before(:each) do
    @subscription = assign(:subscription, Subscription.create!(
      :user_id => 1,
      :subscriptionId => "MyString",
      :planId => "MyString",
      :care_id => 1,
      :payment_intent => "MyString",
      :status => 1
    ))
  end

  it "renders the edit subscription form" do
    render

    assert_select "form[action=?][method=?]", subscription_path(@subscription), "post" do

      assert_select "input[name=?]", "subscription[user_id]"

      assert_select "input[name=?]", "subscription[subscriptionId]"

      assert_select "input[name=?]", "subscription[planId]"

      assert_select "input[name=?]", "subscription[care_id]"

      assert_select "input[name=?]", "subscription[payment_intent]"

      assert_select "input[name=?]", "subscription[status]"
    end
  end
end
