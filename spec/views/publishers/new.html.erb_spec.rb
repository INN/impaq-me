require 'spec_helper'

describe "publishers/new" do
  before(:each) do
    assign(:publisher, stub_model(Publisher,
      :paypal_link => "MyString",
      :limit => 1,
      :campaign => nil
    ).as_new_record)
  end

  it "renders new publisher form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", publishers_path, "post" do
      assert_select "input#publisher_paypal_link[name=?]", "publisher[paypal_link]"
      assert_select "input#publisher_limit[name=?]", "publisher[limit]"
      assert_select "input#publisher_campaign[name=?]", "publisher[campaign]"
    end
  end
end
