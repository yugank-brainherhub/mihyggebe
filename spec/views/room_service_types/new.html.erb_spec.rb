require 'rails_helper'

RSpec.describe "room_service_types/new", type: :view do
  before(:each) do
    assign(:room_service_type, RoomServiceType.new(
      :name => "MyString"
    ))
  end

  it "renders new room_service_type form" do
    render

    assert_select "form[action=?][method=?]", room_service_types_path, "post" do

      assert_select "input[name=?]", "room_service_type[name]"
    end
  end
end
