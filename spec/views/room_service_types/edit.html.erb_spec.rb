require 'rails_helper'

RSpec.describe "room_service_types/edit", type: :view do
  before(:each) do
    @room_service_type = assign(:room_service_type, RoomServiceType.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit room_service_type form" do
    render

    assert_select "form[action=?][method=?]", room_service_type_path(@room_service_type), "post" do

      assert_select "input[name=?]", "room_service_type[name]"
    end
  end
end
