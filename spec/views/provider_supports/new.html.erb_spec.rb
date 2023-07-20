require 'rails_helper'

RSpec.describe "provider_supports/new", type: :view do
  before(:each) do
    assign(:provider_support, ProviderSupport.new(
      :name => "MyString",
      :contact_type => "MyString",
      :active => false,
      :user_id => 1,
      :phone_number => "MyString",
      :email => "MyString"
    ))
  end

  it "renders new provider_support form" do
    render

    assert_select "form[action=?][method=?]", provider_supports_path, "post" do

      assert_select "input[name=?]", "provider_support[name]"

      assert_select "input[name=?]", "provider_support[contact_type]"

      assert_select "input[name=?]", "provider_support[active]"

      assert_select "input[name=?]", "provider_support[user_id]"

      assert_select "input[name=?]", "provider_support[phone_number]"

      assert_select "input[name=?]", "provider_support[email]"
    end
  end
end
