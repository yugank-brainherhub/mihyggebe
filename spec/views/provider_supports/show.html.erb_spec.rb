require 'rails_helper'

RSpec.describe "provider_supports/show", type: :view do
  before(:each) do
    @provider_support = assign(:provider_support, ProviderSupport.create!(
      :name => "Name",
      :contact_type => "Contact Type",
      :active => false,
      :user_id => 2,
      :phone_number => "Phone Number",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Contact Type/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Email/)
  end
end
