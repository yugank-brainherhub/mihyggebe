require 'rails_helper'

RSpec.describe "staff_details/new", type: :view do
  before(:each) do
    assign(:staff_detail, StaffDetail.new(
      :name => "MyString",
      :staff_role_id => 1,
      :care_id => 1
    ))
  end

  it "renders new staff_detail form" do
    render

    assert_select "form[action=?][method=?]", staff_details_path, "post" do

      assert_select "input[name=?]", "staff_detail[name]"

      assert_select "input[name=?]", "staff_detail[staff_role_id]"

      assert_select "input[name=?]", "staff_detail[care_id]"
    end
  end
end
