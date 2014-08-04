class AddDeactivateDeleteStartAndEndDatesToCampaigns < ActiveRecord::Migration
  def change
    change_table :campaigns do |t|
      t.boolean :deleted, :default => false
      t.timestamp :starts_at
      t.timestamp :ends_at
    end
  end
end
