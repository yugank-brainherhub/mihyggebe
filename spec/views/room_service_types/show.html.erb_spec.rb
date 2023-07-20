require 'rails_helper'

RSpec.describe "room_service_types/show", type: :view do
  before(:each) do
    @room_service_type = assign(:room_service_type, RoomServiceType.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
