class MigrationArticle < ActiveRecord::Base
  self.table_name = :articles
  has_many :links, :class_name => "MigrationLink"
  has_many :shares, :class_name => "MigrationShare"
  has_many :click_throughs, :class_name => "MigrationClickThrough"
end

class MigrationLink < ActiveRecord::Base
  self.table_name = :links
  belongs_to :article, :class_name => "MigrationArticle"
end

class MigrationShare < ActiveRecord::Base
  self.table_name = :shares
  belongs_to :article, :class_name => "MigrationArticle"
end

class MigrationClickThrough < ActiveRecord::Base
  self.table_name = :click_throughs
  belongs_to :article, :class_name => "MigrationArticle"
end

def convert_stuff!
  puts "### Converting migration links"
  MigrationLink.where(:article_id => nil).find_in_batches(:batch_size => batch_size = 5000).each_with_index do |batch, i|
    ActiveRecord::Base.transaction do
      batch.each do |link|
        url = link.long_url

        MigrationArticle.find_or_create_by!(:url => url, :campaign_id => link.campaign_id).tap do |article|
          link.update!(:article_id => article.id)
          MigrationClickThrough.where(:campaign_id => link.campaign_id, :article_url => url).update_all(:article_id => article.id)
          MigrationShare.where(:campaign_id => link.campaign_id, :article_url => url).update_all(:article_id => article.id)
        end
      end
    end

    puts "### Processed #{i * batch_size + batch_size} links"
  end

  puts "### Orphaned Links remaining: #{MigrationLink.where('article_id is null').count}"
  puts "### Orphaned ClickThroughs remaining: #{MigrationClickThrough.where('article_id is null').count}"
  puts "### Orphaned Shares remaining: #{MigrationShare.where('article_id is null').count}"
end


class DataMigrationToCanonicalArticles < ActiveRecord::Migration
  def up
    convert_stuff!
  end

  def down
    # No logical down ability, but it's a data migration so there's no structural need for one.
  end
end
