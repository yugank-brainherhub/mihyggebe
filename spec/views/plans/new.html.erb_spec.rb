require 'rails_helper'

RSpec.describe "plans/new", type: :view do
  before(:each) do
    assign(:plan, Plan.new(
      :min => 1,
      :max => 1,
      :planId => "MyString",
      :price => 1.5,
      :status => 1
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", plans_path, "post" do

      assert_select "input[name=?]", "plan[min]"

      assert_select "input[name=?]", "plan[max]"

      assert_select "input[name=?]", "plan[planId]"

      assert_select "input[name=?]", "plan[price]"

      assert_select "input[name=?]", "plan[status]"
    end
  end
end
