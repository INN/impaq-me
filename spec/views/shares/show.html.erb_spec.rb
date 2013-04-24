require 'spec_helper'

describe "shares/show" do
  before(:each) do
    @share = assign(:share, stub_model(Share,
      :ip => "Ip",
      :facebook => "Facebook",
      :twitter => "Twitter",
      :message => "Message",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ip/)
    rendered.should match(/Facebook/)
    rendered.should match(/Twitter/)
    rendered.should match(/Message/)
    rendered.should match(/Url/)
  end
end
