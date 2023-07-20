require 'rails_helper'

RSpec.describe "rooms/edit", type: :view do
  before(:each) do
    @room = assign(:room, Room.create!(
      :name => "MyString",
      :room_type => 1,
      :bathroom_type => 1,
      :price => 1.5,
      :price_desc => "MyText",
      :care_id => 1,
      :beds_count => 1
    ))
  end

  it "renders the edit room form" do
    render

    assert_select "form[action=?][method=?]", room_path(@room), "post" do

      assert_select "input[name=?]", "room[name]"

      assert_select "input[name=?]", "room[room_type]"

      assert_select "input[name=?]", "room[bathroom_type]"

      assert_select "input[name=?]", "room[price]"

      assert_select "textarea[name=?]", "room[price_desc]"

      assert_select "input[name=?]", "room[care_id]"

      assert_select "input[name=?]", "room[beds_count]"
    end
  end
end
