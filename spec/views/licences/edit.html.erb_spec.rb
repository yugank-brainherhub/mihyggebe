require 'rails_helper'

RSpec.describe "licences/edit", type: :view do
  before(:each) do
    @licence = assign(:licence, Licence.create!(
      :name => "MyString",
      :licence_type => "MyString"
    ))
  end

  it "renders the edit licence form" do
    render

    assert_select "form[action=?][method=?]", licence_path(@licence), "post" do

      assert_select "input[name=?]", "licence[name]"

      assert_select "input[name=?]", "licence[licence_type]"
    end
  end
end
