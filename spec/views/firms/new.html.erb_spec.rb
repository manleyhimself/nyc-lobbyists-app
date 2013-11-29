require 'spec_helper'

describe "firms/new" do
  before(:each) do
    assign(:firm, stub_model(Firm,
      :name => "MyString",
      :address => "MyText"
    ).as_new_record)
  end

  it "renders new firm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", firms_path, "post" do
      assert_select "input#firm_name[name=?]", "firm[name]"
      assert_select "textarea#firm_address[name=?]", "firm[address]"
    end
  end
end
