require 'spec_helper'

describe "shares/index" do
  before(:each) do
    assign(:shares, [
      stub_model(Share,
        :ip => "Ip",
        :facebook => "Facebook",
        :twitter => "Twitter",
        :message => "Message",
        :url => "Url"
      ),
      stub_model(Share,
        :ip => "Ip",
        :facebook => "Facebook",
        :twitter => "Twitter",
        :message => "Message",
        :url => "Url"
      )
    ])
  end

  it "renders a list of shares" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook".to_s, :count => 2
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
