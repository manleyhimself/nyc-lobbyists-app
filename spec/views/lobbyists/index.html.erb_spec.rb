require 'spec_helper'

describe "lobbyists/index" do
  before(:each) do
    assign(:lobbyists, [
      stub_model(Lobbyist,
        :name => "Name",
        :firm_id => 1
      ),
      stub_model(Lobbyist,
        :name => "Name",
        :firm_id => 1
      )
    ])
  end

  it "renders a list of lobbyists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
