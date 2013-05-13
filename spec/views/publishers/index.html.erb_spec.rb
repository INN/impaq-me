require 'spec_helper'

describe "publishers/index" do
  before(:each) do
    assign(:publishers, [
      stub_model(Publisher,
        :paypal_link => "Paypal Link",
        :limit => 1,
        :campaign => nil
      ),
      stub_model(Publisher,
        :paypal_link => "Paypal Link",
        :limit => 1,
        :campaign => nil
      )
    ])
  end

  it "renders a list of publishers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Paypal Link".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
