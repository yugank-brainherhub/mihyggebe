require 'rails_helper'

RSpec.describe "licences/new", type: :view do
  before(:each) do
    assign(:licence, Licence.new(
      :name => "MyString",
      :licence_type => "MyString"
    ))
  end

  it "renders new licence form" do
    render

    assert_select "form[action=?][method=?]", licences_path, "post" do

      assert_select "input[name=?]", "licence[name]"

      assert_select "input[name=?]", "licence[licence_type]"
    end
  end
end
