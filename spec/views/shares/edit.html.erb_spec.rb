require 'spec_helper'

describe "shares/edit" do
  before(:each) do
    @share = assign(:share, stub_model(Share,
      :ip => "MyString",
      :facebook => "MyString",
      :twitter => "MyString",
      :message => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit share form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", share_path(@share), "post" do
      assert_select "input#share_ip[name=?]", "share[ip]"
      assert_select "input#share_facebook[name=?]", "share[facebook]"
      assert_select "input#share_twitter[name=?]", "share[twitter]"
      assert_select "input#share_message[name=?]", "share[message]"
      assert_select "input#share_url[name=?]", "share[url]"
    end
  end
end
