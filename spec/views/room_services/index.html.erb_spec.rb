require 'rails_helper'

RSpec.describe "room_services/index", type: :view do
  before(:each) do
    assign(:room_services, [
      RoomService.create!(
        :name => "Name",
        :room_service_type_id => 2
      ),
      RoomService.create!(
        :name => "Name",
        :room_service_type_id => 2
      )
    ])
  end

  it "renders a list of room_services" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
