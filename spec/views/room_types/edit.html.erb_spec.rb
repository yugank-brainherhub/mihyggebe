require 'rails_helper'

RSpec.describe "room_types/edit", type: :view do
  before(:each) do
    @room_type = assign(:room_type, RoomType.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit room_type form" do
    render

    assert_select "form[action=?][method=?]", room_type_path(@room_type), "post" do

      assert_select "input[name=?]", "room_type[name]"
    end
  end
end
