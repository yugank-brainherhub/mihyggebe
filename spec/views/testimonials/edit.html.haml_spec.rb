require 'rails_helper'

RSpec.describe "testimonials/edit", type: :view do
  before(:each) do
    @testimonial = assign(:testimonial, Testimonial.create!(
      :name => "MyString",
      :description => "MyText",
      :publish => false,
      :testimonial_type => "MyString",
      :location => "MyString",
      :gender => "MyString"
    ))
  end

  it "renders the edit testimonial form" do
    render

    assert_select "form[action=?][method=?]", testimonial_path(@testimonial), "post" do

      assert_select "input[name=?]", "testimonial[name]"

      assert_select "textarea[name=?]", "testimonial[description]"

      assert_select "input[name=?]", "testimonial[publish]"

      assert_select "input[name=?]", "testimonial[testimonial_type]"

      assert_select "input[name=?]", "testimonial[location]"

      assert_select "input[name=?]", "testimonial[gender]"
    end
  end
end
