require 'spec_helper'

describe "publishers/edit" do
  before(:each) do
    @publisher = assign(:publisher, stub_model(Publisher,
      :paypal_link => "MyString",
      :limit => 1,
      :campaign => nil
    ))
  end

  it "renders the edit publisher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", publisher_path(@publisher), "post" do
      assert_select "input#publisher_paypal_link[name=?]", "publisher[paypal_link]"
      assert_select "input#publisher_limit[name=?]", "publisher[limit]"
      assert_select "input#publisher_campaign[name=?]", "publisher[campaign]"
    end
  end
end
