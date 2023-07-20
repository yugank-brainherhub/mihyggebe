require 'rails_helper'

RSpec.describe "staff_details/show", type: :view do
  before(:each) do
    @staff_detail = assign(:staff_detail, StaffDetail.create!(
      :name => "Name",
      :staff_role_id => 2,
      :care_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
