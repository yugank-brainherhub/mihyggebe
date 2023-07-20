require 'rails_helper'

RSpec.describe "facilities/new", type: :view do
  before(:each) do
    assign(:facility, Facility.new(
      :name => "MyString",
      :facility_type_id => ""
    ))
  end

  it "renders new facility form" do
    render

    assert_select "form[action=?][method=?]", facilities_path, "post" do

      assert_select "input[name=?]", "facility[name]"

      assert_select "input[name=?]", "facility[facility_type_id]"
    end
  end
end
