require 'rails_helper'

RSpec.describe "podcasts/new", type: :view do
  before(:each) do
    assign(:podcast, Podcast.new(
      :title => "MyString",
      :description => "MyText",
      :artwork_image => "MyString",
      :publish => false
    ))
  end

  it "renders new podcast form" do
    render

    assert_select "form[action=?][method=?]", podcasts_path, "post" do

      assert_select "input[name=?]", "podcast[title]"

      assert_select "textarea[name=?]", "podcast[description]"

      assert_select "input[name=?]", "podcast[artwork_image]"

      assert_select "input[name=?]", "podcast[publish]"
    end
  end
end
