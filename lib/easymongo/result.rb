module Easymongo
  class Result

    attr_reader :result

    # Init takes a Mongo::Operation::Result
    def initialize(result)
      @result = result
    end

    # Get the id as BSON::ObjectId
    def bson_id
      result.upserted_id rescue nil
    end

    # Get the id if available
    def id
      bson_id ? bson_id.to_s : nil
    end

    # Creation date
    def date
      bson_id ? bson_id.generation_time : nil
    end

    # For the mongo operation result
    def method_missing(name, *args, &block)
      return result.send(name, *args) if result.respond_to?(name)
      super
    end

  end
end
