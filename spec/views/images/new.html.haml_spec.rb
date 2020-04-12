require 'rails_helper'

RSpec.describe "images/new", type: :view do
  before(:each) do
    assign(:image, Image.new(
      title: "MyString",
      licence: "MyString",
      source: "MyText",
      creator: "MyString",
      place: nil,
      alt: "MyString",
      caption: "MyString",
      sorting: 1,
      preview: false
    ))
  end

  it "renders new image form" do
    render

    assert_select "form[action=?][method=?]", images_path, "post" do

      assert_select "input[name=?]", "image[title]"

      assert_select "input[name=?]", "image[licence]"

      assert_select "textarea[name=?]", "image[source]"

      assert_select "input[name=?]", "image[creator]"

      assert_select "input[name=?]", "image[place_id]"

      assert_select "input[name=?]", "image[alt]"

      assert_select "input[name=?]", "image[caption]"

      assert_select "input[name=?]", "image[sorting]"

      assert_select "input[name=?]", "image[preview]"
    end
  end
end