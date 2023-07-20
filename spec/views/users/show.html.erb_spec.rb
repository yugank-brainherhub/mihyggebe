require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Mobile/)
    expect(rendered).to match(/Messenger/)
    expect(rendered).to match(/Stripe/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Organization/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Profession/)
    expect(rendered).to match(/Docusign Status/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Account/)
    expect(rendered).to match(/Checkr/)
    expect(rendered).to match(/Invitation Status/)
  end
end
