require 'spec_helper'

describe "lobbyists/new" do
  before(:each) do
    assign(:lobbyist, stub_model(Lobbyist,
      :name => "MyString",
      :firm_id => 1
    ).as_new_record)
  end

  it "renders new lobbyist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lobbyists_path, "post" do
      assert_select "input#lobbyist_name[name=?]", "lobbyist[name]"
      assert_select "input#lobbyist_firm_id[name=?]", "lobbyist[firm_id]"
    end
  end
end
