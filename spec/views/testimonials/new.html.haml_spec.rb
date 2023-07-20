require 'rails_helper'

RSpec.describe "testimonials/new", type: :view do
  before(:each) do
    assign(:testimonial, Testimonial.new(
      :name => "MyString",
      :description => "MyText",
      :publish => false,
      :testimonial_type => "MyString",
      :location => "MyString",
      :gender => "MyString"
    ))
  end

  it "renders new testimonial form" do
    render

    assert_select "form[action=?][method=?]", testimonials_path, "post" do

      assert_select "input[name=?]", "testimonial[name]"

      assert_select "textarea[name=?]", "testimonial[description]"

      assert_select "input[name=?]", "testimonial[publish]"

      assert_select "input[name=?]", "testimonial[testimonial_type]"

      assert_select "input[name=?]", "testimonial[location]"

      assert_select "input[name=?]", "testimonial[gender]"
    end
  end
end
