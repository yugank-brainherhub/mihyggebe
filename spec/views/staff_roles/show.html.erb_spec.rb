require 'rails_helper'

RSpec.describe "staff_roles/show", type: :view do
  before(:each) do
    @staff_role = assign(:staff_role, StaffRole.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
