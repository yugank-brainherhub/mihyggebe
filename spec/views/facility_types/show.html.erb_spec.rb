require 'rails_helper'

RSpec.describe "facility_types/show", type: :view do
  before(:each) do
    @facility_type = assign(:facility_type, FacilityType.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
