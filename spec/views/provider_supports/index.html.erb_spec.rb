require 'rails_helper'

RSpec.describe "provider_supports/index", type: :view do
  before(:each) do
    assign(:provider_supports, [
      ProviderSupport.create!(
        :name => "Name",
        :contact_type => "Contact Type",
        :active => false,
        :user_id => 2,
        :phone_number => "Phone Number",
        :email => "Email"
      ),
      ProviderSupport.create!(
        :name => "Name",
        :contact_type => "Contact Type",
        :active => false,
        :user_id => 2,
        :phone_number => "Phone Number",
        :email => "Email"
      )
    ])
  end

  it "renders a list of provider_supports" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
