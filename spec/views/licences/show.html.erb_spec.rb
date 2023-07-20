require 'rails_helper'

RSpec.describe "licences/show", type: :view do
  before(:each) do
    @licence = assign(:licence, Licence.create!(
      :name => "Name",
      :licence_type => "Licence Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Licence Type/)
  end
end
