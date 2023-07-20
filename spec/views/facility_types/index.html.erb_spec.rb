require 'rails_helper'

RSpec.describe "facility_types/index", type: :view do
  before(:each) do
    assign(:facility_types, [
      FacilityType.create!(
        :name => "Name"
      ),
      FacilityType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of facility_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
