require 'rails_helper'

RSpec.describe "beds/show", type: :view do
  before(:each) do
    @bed = assign(:bed, Bed.create!(
      :bed_number => "Bed Number",
      :bed_type => 2,
      :room_id => "",
      :service_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Bed Number/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(/3/)
  end
end
