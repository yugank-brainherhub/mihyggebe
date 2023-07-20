require 'rails_helper'

RSpec.describe "wishlists/index", type: :view do
  before(:each) do
    assign(:wishlists, [
      Wishlist.create!(
        :name => "Name",
        :user_id => 2,
        :care_id => 3
      ),
      Wishlist.create!(
        :name => "Name",
        :user_id => 2,
        :care_id => 3
      )
    ])
  end

  it "renders a list of wishlists" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
