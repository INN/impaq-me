require 'spec_helper'

describe "campaigns/show" do
  before(:each) do
    @campaign = assign(:campaign, stub_model(Campaign,
      :name => "Name",
      :publisher_name => "Publisher Name",
      :domain => "",
      :value_per_share => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Publisher Name/)
    rendered.should match(//)
    rendered.should match(/9.99/)
  end
end
