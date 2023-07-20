require 'rails_helper'

RSpec.describe "room_services/show", type: :view do
  before(:each) do
    @room_service = assign(:room_service, RoomService.create!(
      :name => "Name",
      :room_service_type_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
