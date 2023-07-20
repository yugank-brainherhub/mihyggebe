require 'rails_helper'

RSpec.describe "testimonials/index", type: :view do
  before(:each) do
    assign(:testimonials, [
      Testimonial.create!(
        :name => "Name",
        :description => "MyText",
        :publish => false,
        :testimonial_type => "Testimonial Type",
        :location => "Location",
        :gender => "Gender"
      ),
      Testimonial.create!(
        :name => "Name",
        :description => "MyText",
        :publish => false,
        :testimonial_type => "Testimonial Type",
        :location => "Location",
        :gender => "Gender"
      )
    ])
  end

  it "renders a list of testimonials" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Testimonial Type".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
  end
end
