require 'rails_helper'

RSpec.describe "beds/new", type: :view do
  before(:each) do
    assign(:bed, Bed.new(
      :bed_number => "MyString",
      :bed_type => 1,
      :room_id => "",
      :service_id => 1
    ))
  end

  it "renders new bed form" do
    render

    assert_select "form[action=?][method=?]", beds_path, "post" do

      assert_select "input[name=?]", "bed[bed_number]"

      assert_select "input[name=?]", "bed[bed_type]"

      assert_select "input[name=?]", "bed[room_id]"

      assert_select "input[name=?]", "bed[service_id]"
    end
  end
end
