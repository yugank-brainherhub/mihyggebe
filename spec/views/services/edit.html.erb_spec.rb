require 'rails_helper'

RSpec.describe "services/edit", type: :view do
  before(:each) do
    @service = assign(:service, Service.create!(
      :name => "MyString",
      :service_type_id => "",
      :desc => "MyText"
    ))
  end

  it "renders the edit service form" do
    render

    assert_select "form[action=?][method=?]", service_path(@service), "post" do

      assert_select "input[name=?]", "service[name]"

      assert_select "input[name=?]", "service[service_type_id]"

      assert_select "textarea[name=?]", "service[desc]"
    end
  end
end
