require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :role_id => "",
        :mobile => "Mobile",
        :messenger => "Messenger",
        :stripeID => "Stripe",
        :above18 => false,
        :organization => "Organization",
        :address => "MyText",
        :profession => "Profession",
        :docusign_status => "Docusign Status",
        :status => false,
        :checkr_status => 2,
        :accountId => "Account",
        :checkrId => "Checkr",
        :invitation_status => "Invitation Status"
      ),
      User.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :role_id => "",
        :mobile => "Mobile",
        :messenger => "Messenger",
        :stripeID => "Stripe",
        :above18 => false,
        :organization => "Organization",
        :address => "MyText",
        :profession => "Profession",
        :docusign_status => "Docusign Status",
        :status => false,
        :checkr_status => 2,
        :accountId => "Account",
        :checkrId => "Checkr",
        :invitation_status => "Invitation Status"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile".to_s, :count => 2
    assert_select "tr>td", :text => "Messenger".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Organization".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Profession".to_s, :count => 2
    assert_select "tr>td", :text => "Docusign Status".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Account".to_s, :count => 2
    assert_select "tr>td", :text => "Checkr".to_s, :count => 2
    assert_select "tr>td", :text => "Invitation Status".to_s, :count => 2
  end
end
