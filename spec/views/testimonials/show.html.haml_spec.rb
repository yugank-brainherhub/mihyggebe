require 'rails_helper'

RSpec.describe "testimonials/show", type: :view do
  before(:each) do
    @testimonial = assign(:testimonial, Testimonial.create!(
      :name => "Name",
      :description => "MyText",
      :publish => false,
      :testimonial_type => "Testimonial Type",
      :location => "Location",
      :gender => "Gender"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Testimonial Type/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Gender/)
  end
end
