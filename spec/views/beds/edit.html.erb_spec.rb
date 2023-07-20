require 'rails_helper'

RSpec.describe "beds/edit", type: :view do
  before(:each) do
    @bed = assign(:bed, Bed.create!(
      :bed_number => "MyString",
      :bed_type => 1,
      :room_id => "",
      :service_id => 1
    ))
  end

  it "renders the edit bed form" do
    render

    assert_select "form[action=?][method=?]", bed_path(@bed), "post" do

      assert_select "input[name=?]", "bed[bed_number]"

      assert_select "input[name=?]", "bed[bed_type]"

      assert_select "input[name=?]", "bed[room_id]"

      assert_select "input[name=?]", "bed[service_id]"
    end
  end
end
