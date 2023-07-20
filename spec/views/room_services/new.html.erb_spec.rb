require 'rails_helper'

RSpec.describe "room_services/new", type: :view do
  before(:each) do
    assign(:room_service, RoomService.new(
      :name => "MyString",
      :room_service_type_id => 1
    ))
  end

  it "renders new room_service form" do
    render

    assert_select "form[action=?][method=?]", room_services_path, "post" do

      assert_select "input[name=?]", "room_service[name]"

      assert_select "input[name=?]", "room_service[room_service_type_id]"
    end
  end
end
