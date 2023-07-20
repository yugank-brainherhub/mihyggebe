require 'rails_helper'

RSpec.describe "staff_roles/new", type: :view do
  before(:each) do
    assign(:staff_role, StaffRole.new(
      :name => "MyString"
    ))
  end

  it "renders new staff_role form" do
    render

    assert_select "form[action=?][method=?]", staff_roles_path, "post" do

      assert_select "input[name=?]", "staff_role[name]"
    end
  end
end
