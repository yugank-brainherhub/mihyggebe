require 'rails_helper'

RSpec.describe "mihygge_supports/index", type: :view do
  before(:each) do
    assign(:mihygge_supports, [
      MihyggeSupport.create!(
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
      ),
      MihyggeSupport.create!(
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
      )
    ])
  end

  it "renders a list of mihygge_supports" do
    render
    assert_select "tr>td", :text => "Support Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "File 1".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Support Number".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
