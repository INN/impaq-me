# Sql::ConvertsEverything.new.convert
module Sql
  class ConvertsEverything
    def initialize(searches_for_existing = false)
      @searches_for_existing = searches_for_existing
      @converts_object = ConvertsFromMongo.new(searches_for_existing)
    end

    def convert
      ::Mongo::User.all.no_timeout.each do |mongo_user|
        @converts_object.convert(mongo_user, ::User)
      end

      ::Mongo::Campaign.all.no_timeout.each do |c|
        if ::Campaign.find_by(:mongo_id => c.id.to_s).present?
          puts "Skipping '#{c.publisher_name}' campaign"
        else
          puts "Converting '#{c.publisher_name}' campaign. It has #{c.links.count} links, #{c.shares.count} shares, #{c.click_throughs.count} clicks"
          @converts_object.convert(c, ::Campaign)
          puts "Campaign complete. We have so far committed #{(Link.count + Campaign.count + ClickThrough.count + Share.count + Variant.count + PaypalDonation.count)} things."
        end
      end
    end
  end
end
