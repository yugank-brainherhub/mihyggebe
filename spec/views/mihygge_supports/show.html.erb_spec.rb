require 'rails_helper'

RSpec.describe "mihygge_supports/show", type: :view do
  before(:each) do
    @mihygge_support = assign(:mihygge_support, MihyggeSupport.create!(
      :support_type => "Support Type",
      :description => "MyText",
      :file_1 => "File 1",
      :user_id => 2,
      :email => "Email",
      :phone_number => "Phone Number",
      :first_name => "First Name",
      :last_name => "Last Name",
      :support_number => "Support Number",
      :is_provider => false,
      :provider_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Support Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/File 1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Support Number/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
  end
end
