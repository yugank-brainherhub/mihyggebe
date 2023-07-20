require 'rails_helper'

RSpec.describe "rooms/index", type: :view do
  before(:each) do
    assign(:rooms, [
      Room.create!(
        :name => "Name",
        :room_type => 2,
        :bathroom_type => 3,
        :price => 4.5,
        :price_desc => "MyText",
        :care_id => 5,
        :beds_count => 6
      ),
      Room.create!(
        :name => "Name",
        :room_type => 2,
        :bathroom_type => 3,
        :price => 4.5,
        :price_desc => "MyText",
        :care_id => 5,
        :beds_count => 6
      )
    ])
  end

  it "renders a list of rooms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
