require 'rails_helper'

RSpec.describe "licences/index", type: :view do
  before(:each) do
    assign(:licences, [
      Licence.create!(
        :name => "Name",
        :licence_type => "Licence Type"
      ),
      Licence.create!(
        :name => "Name",
        :licence_type => "Licence Type"
      )
    ])
  end

  it "renders a list of licences" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Licence Type".to_s, :count => 2
  end
end
