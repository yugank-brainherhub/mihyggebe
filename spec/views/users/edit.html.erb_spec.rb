require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :role_id => "",
      :mobile => "MyString",
      :messenger => "MyString",
      :stripeID => "MyString",
      :above18 => false,
      :organization => "MyString",
      :address => "MyText",
      :profession => "MyString",
      :docusign_status => "MyString",
      :status => false,
      :checkr_status => 1,
      :accountId => "MyString",
      :checkrId => "MyString",
      :invitation_status => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[role_id]"

      assert_select "input[name=?]", "user[mobile]"

      assert_select "input[name=?]", "user[messenger]"

      assert_select "input[name=?]", "user[stripeID]"

      assert_select "input[name=?]", "user[above18]"

      assert_select "input[name=?]", "user[organization]"

      assert_select "textarea[name=?]", "user[address]"

      assert_select "input[name=?]", "user[profession]"

      assert_select "input[name=?]", "user[docusign_status]"

      assert_select "input[name=?]", "user[status]"

      assert_select "input[name=?]", "user[checkr_status]"

      assert_select "input[name=?]", "user[accountId]"

      assert_select "input[name=?]", "user[checkrId]"

      assert_select "input[name=?]", "user[invitation_status]"
    end
  end
end
