require 'spec_helper'

describe "agencies/edit" do
  before(:each) do
    @agency = assign(:agency, stub_model(Agency,
      :name => "MyString",
      :address => "MyText",
      :description => "MyText"
    ))
  end

  it "renders the edit agency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", agency_path(@agency), "post" do
      assert_select "input#agency_name[name=?]", "agency[name]"
      assert_select "textarea#agency_address[name=?]", "agency[address]"
      assert_select "textarea#agency_description[name=?]", "agency[description]"
    end
  end
end
