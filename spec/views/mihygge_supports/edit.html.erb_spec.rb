require 'rails_helper'

RSpec.describe "mihygge_supports/edit", type: :view do
  before(:each) do
    @mihygge_support = assign(:mihygge_support, MihyggeSupport.create!(
      :support_type => "MyString",
      :description => "MyText",
      :file_1 => "MyString",
      :user_id => 1,
      :email => "MyString",
      :phone_number => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :support_number => "MyString",
      :is_provider => false,
      :provider_id => 1
    ))
  end

  it "renders the edit mihygge_support form" do
    render

    assert_select "form[action=?][method=?]", mihygge_support_path(@mihygge_support), "post" do

      assert_select "input[name=?]", "mihygge_support[support_type]"

      assert_select "textarea[name=?]", "mihygge_support[description]"

      assert_select "input[name=?]", "mihygge_support[file_1]"

      assert_select "input[name=?]", "mihygge_support[user_id]"

      assert_select "input[name=?]", "mihygge_support[email]"

      assert_select "input[name=?]", "mihygge_support[phone_number]"

      assert_select "input[name=?]", "mihygge_support[first_name]"

      assert_select "input[name=?]", "mihygge_support[last_name]"

      assert_select "input[name=?]", "mihygge_support[support_number]"

      assert_select "input[name=?]", "mihygge_support[is_provider]"

      assert_select "input[name=?]", "mihygge_support[provider_id]"
    end
  end
end
