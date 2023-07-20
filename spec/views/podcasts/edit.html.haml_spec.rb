require 'rails_helper'

RSpec.describe "podcasts/edit", type: :view do
  before(:each) do
    @podcast = assign(:podcast, Podcast.create!(
      :title => "MyString",
      :description => "MyText",
      :artwork_image => "MyString",
      :publish => false
    ))
  end

  it "renders the edit podcast form" do
    render

    assert_select "form[action=?][method=?]", podcast_path(@podcast), "post" do

      assert_select "input[name=?]", "podcast[title]"

      assert_select "textarea[name=?]", "podcast[description]"

      assert_select "input[name=?]", "podcast[artwork_image]"

      assert_select "input[name=?]", "podcast[publish]"
    end
  end
end
