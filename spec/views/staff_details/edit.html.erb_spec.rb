require 'rails_helper'

RSpec.describe "staff_details/edit", type: :view do
  before(:each) do
    @staff_detail = assign(:staff_detail, StaffDetail.create!(
      :name => "MyString",
      :staff_role_id => 1,
      :care_id => 1
    ))
  end

  it "renders the edit staff_detail form" do
    render

    assert_select "form[action=?][method=?]", staff_detail_path(@staff_detail), "post" do

      assert_select "input[name=?]", "staff_detail[name]"

      assert_select "input[name=?]", "staff_detail[staff_role_id]"

      assert_select "input[name=?]", "staff_detail[care_id]"
    end
  end
end
