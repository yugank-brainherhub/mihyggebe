require 'rails_helper'

RSpec.describe "service_types/new", type: :view do
  before(:each) do
    assign(:service_type, ServiceType.new())
  end

  it "renders new service_type form" do
    render

    assert_select "form[action=?][method=?]", service_types_path, "post" do
    end
  end
end
