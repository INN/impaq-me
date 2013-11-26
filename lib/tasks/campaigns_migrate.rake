namespace :campaigns do
  desc "Campaign migration task"
  task :migrate => :environment do
    p "Migrating Campaigns..."
    Campaign.each do |campaign|
      p campaign
      campaign.variants << Variant.new(recommended_donation: campaign['recommended_donation'])
      campaign.save
    end
    puts "Migrating Campaigns complete."
  end
end
