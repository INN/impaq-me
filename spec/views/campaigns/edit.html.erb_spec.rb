require 'spec_helper'

describe "campaigns/edit" do
  before(:each) do
    @campaign = assign(:campaign, stub_model(Campaign,
      :name => "MyString",
      :publisher_name => "MyString",
      :domain => "",
      :value_per_share => "9.99"
    ))
  end

  it "renders the edit campaign form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", campaign_path(@campaign), "post" do
      assert_select "input#campaign_name[name=?]", "campaign[name]"
      assert_select "input#campaign_publisher_name[name=?]", "campaign[publisher_name]"
      assert_select "input#campaign_domain[name=?]", "campaign[domain]"
      assert_select "input#campaign_value_per_share[name=?]", "campaign[value_per_share]"
    end
  end
end
