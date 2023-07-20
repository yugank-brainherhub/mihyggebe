require 'rails_helper'

RSpec.describe "staff_roles/edit", type: :view do
  before(:each) do
    @staff_role = assign(:staff_role, StaffRole.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit staff_role form" do
    render

    assert_select "form[action=?][method=?]", staff_role_path(@staff_role), "post" do

      assert_select "input[name=?]", "staff_role[name]"
    end
  end
end
