require 'rails_helper'

RSpec.describe "room_services/edit", type: :view do
  before(:each) do
    @room_service = assign(:room_service, RoomService.create!(
      :name => "MyString",
      :room_service_type_id => 1
    ))
  end

  it "renders the edit room_service form" do
    render

    assert_select "form[action=?][method=?]", room_service_path(@room_service), "post" do

      assert_select "input[name=?]", "room_service[name]"

      assert_select "input[name=?]", "room_service[room_service_type_id]"
    end
  end
end
