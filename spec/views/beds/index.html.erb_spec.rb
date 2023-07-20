require 'rails_helper'

RSpec.describe "beds/index", type: :view do
  before(:each) do
    assign(:beds, [
      Bed.create!(
        :bed_number => "Bed Number",
        :bed_type => 2,
        :room_id => "",
        :service_id => 3
      ),
      Bed.create!(
        :bed_number => "Bed Number",
        :bed_type => 2,
        :room_id => "",
        :service_id => 3
      )
    ])
  end

  it "renders a list of beds" do
    render
    assert_select "tr>td", :text => "Bed Number".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
