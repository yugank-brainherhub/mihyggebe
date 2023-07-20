require 'rails_helper'

RSpec.describe "plans/index", type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :min => 2,
        :max => 3,
        :planId => "Plan",
        :price => 4.5,
        :status => 5
      ),
      Plan.create!(
        :min => 2,
        :max => 3,
        :planId => "Plan",
        :price => 4.5,
        :status => 5
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Plan".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
