require 'rails_helper'

RSpec.describe "bookings/index", type: :view do
  before(:each) do
    assign(:bookings, [
      Booking.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :mobile => "Mobile",
        :user_id => 2,
        :bookingID => "Booking",
        :price_includes => "MyText",
        :price_per_bed => 3.5,
        :other_relation => "Other Relation",
        :no_of_guests => 4,
        :doc_received => false,
        :status => 5,
        :care_id => ""
      ),
      Booking.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :mobile => "Mobile",
        :user_id => 2,
        :bookingID => "Booking",
        :price_includes => "MyText",
        :price_per_bed => 3.5,
        :other_relation => "Other Relation",
        :no_of_guests => 4,
        :doc_received => false,
        :status => 5,
        :care_id => ""
      )
    ])
  end

  it "renders a list of bookings" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Booking".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Other Relation".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
