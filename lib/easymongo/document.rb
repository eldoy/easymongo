# The mongodb document

module Easymongo
  class Document

    attr_accessor :doc, :values

    # Takes a BSON::Document
    def initialize(doc)

      # Replace _id with id
      doc['id'] = doc.delete('_id')

      # Convert all BSON::ObjectId to string
      doc.each{|k, v| doc[k] = v.to_s if v.is_a?(BSON::ObjectId)}

      # Symbolize keys
      self.doc = doc.symbolize_keys
    end

    # Get bson id
    def bson_id
      @bson_id ||= BSON::ObjectId.from_string(doc[:id])
    end

    # Creation date
    def date
      bson_id.generation_time
    end

    # Read value
    def [](key)
      doc[key.to_sym]
    end

    # Write value
    def []=(key, value)
      doc[key.to_sym] = value
    end

    # Make the doc user friendly with dot notation
    # Provides access to doc object methods too
    def method_missing(name, *args, &block)

      # Write value
      return doc[name[0..-2].to_sym] = args.first if args.size == 1 and name[-1] == '='

      # Read value
      return doc[name] if doc.has_key?(name)

      # Run method on doc object
      return doc.send(name, *args) if doc.respond_to?(name)
    end

  end
end
