require 'rails_helper'

RSpec.describe "room_service_types/index", type: :view do
  before(:each) do
    assign(:room_service_types, [
      RoomServiceType.create!(
        :name => "Name"
      ),
      RoomServiceType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of room_service_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
