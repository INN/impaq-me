class AddDisabledFlagToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :disabled, :boolean, :default => false
  end
end
