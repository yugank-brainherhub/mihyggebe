require 'rails_helper'

RSpec.describe "podcasts/index", type: :view do
  before(:each) do
    assign(:podcasts, [
      Podcast.create!(
        :title => "Title",
        :description => "MyText",
        :artwork_image => "Artwork Image",
        :publish => false
      ),
      Podcast.create!(
        :title => "Title",
        :description => "MyText",
        :artwork_image => "Artwork Image",
        :publish => false
      )
    ])
  end

  it "renders a list of podcasts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Artwork Image".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
