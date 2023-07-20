require 'rails_helper'

RSpec.describe "plans/show", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :min => 2,
      :max => 3,
      :planId => "Plan",
      :price => 4.5,
      :status => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Plan/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5/)
  end
end
