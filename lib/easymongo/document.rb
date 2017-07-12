# The mongodb document

module Easymongo

  class Document

    attr_accessor :doc, :values

    # Takes a BSON::Document
    def initialize(doc)
      doc['id'] = doc.delete('_id').to_s
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

    # For the mongo doc
    def method_missing(name, *args, &block)

      # Write value
      return doc[name[0..-2].to_sym] = args.first if args.size == 1 and name[-1] == '='

      # Read value
      return doc[name] if doc.has_key?(name)

      # Run method on doc
      return doc.send(name, *args) if doc.respond_to?(name)

    end

  end
end
