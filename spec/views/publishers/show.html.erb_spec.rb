require 'spec_helper'

describe "publishers/show" do
  before(:each) do
    @publisher = assign(:publisher, stub_model(Publisher,
      :paypal_link => "Paypal Link",
      :limit => 1,
      :campaign => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Paypal Link/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
