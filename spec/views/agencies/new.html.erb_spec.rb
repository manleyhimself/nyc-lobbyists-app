require 'spec_helper'

describe "agencies/new" do
  before(:each) do
    assign(:agency, stub_model(Agency,
      :name => "MyString",
      :address => "MyText",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new agency form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", agencies_path, "post" do
      assert_select "input#agency_name[name=?]", "agency[name]"
      assert_select "textarea#agency_address[name=?]", "agency[address]"
      assert_select "textarea#agency_description[name=?]", "agency[description]"
    end
  end
end
