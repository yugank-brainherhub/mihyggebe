require 'rails_helper'

RSpec.describe "bookings/new", type: :view do
  before(:each) do
    assign(:booking, Booking.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :mobile => "MyString",
      :user_id => 1,
      :bookingID => "MyString",
      :price_includes => "MyText",
      :price_per_bed => 1.5,
      :other_relation => "MyString",
      :no_of_guests => 1,
      :doc_received => false,
      :status => 1,
      :care_id => ""
    ))
  end

  it "renders new booking form" do
    render

    assert_select "form[action=?][method=?]", bookings_path, "post" do

      assert_select "input[name=?]", "booking[first_name]"

      assert_select "input[name=?]", "booking[last_name]"

      assert_select "input[name=?]", "booking[email]"

      assert_select "input[name=?]", "booking[mobile]"

      assert_select "input[name=?]", "booking[user_id]"

      assert_select "input[name=?]", "booking[bookingID]"

      assert_select "textarea[name=?]", "booking[price_includes]"

      assert_select "input[name=?]", "booking[price_per_bed]"

      assert_select "input[name=?]", "booking[other_relation]"

      assert_select "input[name=?]", "booking[no_of_guests]"

      assert_select "input[name=?]", "booking[doc_received]"

      assert_select "input[name=?]", "booking[status]"

      assert_select "input[name=?]", "booking[care_id]"
    end
  end
end
