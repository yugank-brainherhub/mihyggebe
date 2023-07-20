require 'rails_helper'

RSpec.describe "staff_roles/index", type: :view do
  before(:each) do
    assign(:staff_roles, [
      StaffRole.create!(
        :name => "Name"
      ),
      StaffRole.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of staff_roles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
