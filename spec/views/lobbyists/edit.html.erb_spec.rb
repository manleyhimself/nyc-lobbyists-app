require 'spec_helper'

describe "lobbyists/edit" do
  before(:each) do
    @lobbyist = assign(:lobbyist, stub_model(Lobbyist,
      :name => "MyString",
      :firm_id => 1
    ))
  end

  it "renders the edit lobbyist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", lobbyist_path(@lobbyist), "post" do
      assert_select "input#lobbyist_name[name=?]", "lobbyist[name]"
      assert_select "input#lobbyist_firm_id[name=?]", "lobbyist[firm_id]"
    end
  end
end
