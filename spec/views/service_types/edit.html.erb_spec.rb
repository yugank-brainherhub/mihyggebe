require 'rails_helper'

RSpec.describe "service_types/edit", type: :view do
  before(:each) do
    @service_type = assign(:service_type, ServiceType.create!())
  end

  it "renders the edit service_type form" do
    render

    assert_select "form[action=?][method=?]", service_type_path(@service_type), "post" do
    end
  end
end
