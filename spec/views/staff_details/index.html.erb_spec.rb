require 'rails_helper'

RSpec.describe "staff_details/index", type: :view do
  before(:each) do
    assign(:staff_details, [
      StaffDetail.create!(
        :name => "Name",
        :staff_role_id => 2,
        :care_id => 3
      ),
      StaffDetail.create!(
        :name => "Name",
        :staff_role_id => 2,
        :care_id => 3
      )
    ])
  end

  it "renders a list of staff_details" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
