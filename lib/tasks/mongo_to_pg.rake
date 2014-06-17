desc "Mongo to postgres conversion"
task :mongo_to_pg => :environment do
  Sql::ConvertsEverything.new.convert
end
