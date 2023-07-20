require 'rails_helper'

RSpec.describe "bookings/show", type: :view do
  before(:each) do
    @booking = assign(:booking, Booking.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Mobile/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Booking/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Other Relation/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(//)
  end
end
