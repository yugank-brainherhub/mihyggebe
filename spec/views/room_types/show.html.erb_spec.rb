require 'rails_helper'

RSpec.describe "room_types/show", type: :view do
  before(:each) do
    @room_type = assign(:room_type, RoomType.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
