# Data migration that removes errant trailing ? marks from textual URLs
# We have been storing URLs this way from day 1 in all cases where there are
# no query params on the URL.

def clean_urls!(table, column)
  sql = <<-SQL
    update #{table}
       set #{column} = regexp_replace(#{column},'\\?$','')
     where #{column} ~ '\\?$'
  SQL
  ActiveRecord::Base.connection.execute(sql)
end

class CleanUrls < ActiveRecord::Migration
  def up
    clean_urls!(:links, :long_url)
    clean_urls!(:shares, :article_url)
    clean_urls!(:click_throughs, :article_url)
  end

  def down
    #not reversible but not worth blowing up.
  end
end
