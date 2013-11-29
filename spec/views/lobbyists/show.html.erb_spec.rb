require 'spec_helper'

describe "lobbyists/show" do
  before(:each) do
    @lobbyist = assign(:lobbyist, stub_model(Lobbyist,
      :name => "Name",
      :firm_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
