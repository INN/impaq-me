require 'spec_helper'

describe "campaigns/index" do
  before(:each) do
    assign(:campaigns, [
      stub_model(Campaign,
        :name => "Name",
        :publisher_name => "Publisher Name",
        :domain => "",
        :value_per_share => "9.99"
      ),
      stub_model(Campaign,
        :name => "Name",
        :publisher_name => "Publisher Name",
        :domain => "",
        :value_per_share => "9.99"
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Publisher Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
