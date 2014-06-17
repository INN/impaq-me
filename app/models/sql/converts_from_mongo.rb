module Sql
  class ConvertsFromMongo
    def initialize(searches_for_existing = false)
      @searches_for_existing = searches_for_existing
    end

    def convert(mongo, ar_type, initial_attrs = {})
      sql = ar_object_for(mongo, ar_type).tap do |sql|
        sql.assign_attributes(initial_attrs)

        keys(mongo, sql).each do |key|
          if key == "_id"
            sql.mongo_id = mongo.id.to_s
          elsif sql.respond_to?("apply_mongo_#{key}!")
            sql.send("apply_mongo_#{key}!", mongo.send(key))
          elsif mongo.respond_to?(key) && !key.end_with?("_id")
            sql.send("#{key}=", mongo.send(key))
          end
        end

        sql.save! if sql.new_record? || sql.changed?
      end

      has_manies_for(ar_type).each do |key|
        mongo_type = key.classify.constantize
        sql_type = sql.send(key).proxy_association.klass
        belongs_to_attrs = {ar_type.to_s.foreign_key => sql.id}
        ids = mongo.send("#{key.singularize}_ids")
        count = ids.size
        puts "Found #{count} related '#{key}' items"
        ids.each_slice(1000).each_with_index do |id_batch, i|
          ActiveRecord::Base.transaction { process_batch(mongo_type, id_batch, sql_type, belongs_to_attrs) }


          if (i+1) % 15 == 0
            ObjectSpace.each_object(ActiveModel::Errors).each do |err|
              err.instance_variable_set("@base", nil)
            end
            ObjectSpace.each_object(ActiveRecord::Associations::HasManyAssociation).each do |err|
              err.instance_variable_set("@owner", nil)
              err.instance_variable_set("@target", nil)
            end
            GC.start
            puts "ran GC: #{GC.stat}"
          end

          puts "Processed #{(i+1) * 1000} of #{count} '#{key}' objects (number of AR objects is #{ObjectSpace.each_object(ActiveRecord::Base).count})"
        end
      end
    end

  private

    def ar_object_for(mongo, ar_type)
      return ar_type.new unless @searches_for_existing
      ar_type.where(:mongo_id => mongo.id.to_s).first || ar_type.new
    end

    def keys(mongo, sql)
      (mongo.attributes.keys + sql.attributes.keys).uniq - ["id"]
    end

    def has_manies_for(ar_type)
      ar_type.respond_to?(:mongo_has_manies) ? ar_type.mongo_has_manies : []
    end

    def process_batch(mongo_type, id_batch, sql_type, belongs_to_attrs)
      mongo_type.find(id_batch).each do |mongo_has_many|
        convert(mongo_has_many, sql_type, belongs_to_attrs)
      end
    end
  end
end
