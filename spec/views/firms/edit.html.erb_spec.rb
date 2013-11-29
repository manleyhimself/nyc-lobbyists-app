require 'spec_helper'

describe "firms/edit" do
  before(:each) do
    @firm = assign(:firm, stub_model(Firm,
      :name => "MyString",
      :address => "MyText"
    ))
  end

  it "renders the edit firm form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", firm_path(@firm), "post" do
      assert_select "input#firm_name[name=?]", "firm[name]"
      assert_select "textarea#firm_address[name=?]", "firm[address]"
    end
  end
end
