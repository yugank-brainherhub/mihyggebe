require 'rails_helper'

RSpec.describe "service_types/index", type: :view do
  before(:each) do
    assign(:service_types, [
      ServiceType.create!(),
      ServiceType.create!()
    ])
  end

  it "renders a list of service_types" do
    render
  end
end
