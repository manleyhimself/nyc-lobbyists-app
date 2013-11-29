require 'spec_helper'

describe "firms/index" do
  before(:each) do
    assign(:firms, [
      stub_model(Firm,
        :name => "Name",
        :address => "MyText"
      ),
      stub_model(Firm,
        :name => "Name",
        :address => "MyText"
      )
    ])
  end

  it "renders a list of firms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
