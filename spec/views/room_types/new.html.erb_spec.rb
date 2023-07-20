require 'rails_helper'

RSpec.describe "room_types/new", type: :view do
  before(:each) do
    assign(:room_type, RoomType.new(
      :name => "MyString"
    ))
  end

  it "renders new room_type form" do
    render

    assert_select "form[action=?][method=?]", room_types_path, "post" do

      assert_select "input[name=?]", "room_type[name]"
    end
  end
end
