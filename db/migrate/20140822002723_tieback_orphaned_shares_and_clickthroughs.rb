class MigrationArticle < ActiveRecord::Base
  self.table_name = :articles
  has_many :shares, :class_name => "MigrationShare"
  has_many :click_throughs, :class_name => "MigrationClickThrough"
end

class MigrationShare < ActiveRecord::Base
  self.table_name = :shares
  belongs_to :article, :class_name => "MigrationArticle"
end

class MigrationClickThrough < ActiveRecord::Base
  self.table_name = :click_throughs
  belongs_to :article, :class_name => "MigrationArticle"
end

class TiebackOrphanedSharesAndClickthroughs < ActiveRecord::Migration
  def up
    [MigrationShare, MigrationClickThrough].each do |cls|
      cls.where(:article_id => nil).group_by(&:article_url).each do |(url, models)|
        if article = MigrationArticle.find_by(:url => url)
          cls.where(:id => models.map(&:id)).update_all(:article_id => article.id)
        end
      end
    end

    puts "### Orphaned ClickThroughs remaining: #{MigrationClickThrough.where('article_id is null').count}"
    puts "### Orphaned Shares remaining: #{MigrationShare.where('article_id is null').count}"
  end

  def down
    # data migration, no down makes sense but not worth raising
  end
end
