require 'rails_helper'

RSpec.describe "room_types/index", type: :view do
  before(:each) do
    assign(:room_types, [
      RoomType.create!(
        :name => "Name"
      ),
      RoomType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of room_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
