require 'rails_helper'

RSpec.describe "podcasts/show", type: :view do
  before(:each) do
    @podcast = assign(:podcast, Podcast.create!(
      :title => "Title",
      :description => "MyText",
      :artwork_image => "Artwork Image",
      :publish => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Artwork Image/)
    expect(rendered).to match(/false/)
  end
end
