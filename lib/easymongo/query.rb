# This is the easiest possible implementation of a mongodb client.
# We got rid of the ObjectID and the underscore, and made mongodb super easy to use.
#
# If you need something close to pure Mongo, check out https://github.com/fugroup/minimongo
# If you need models for Easymongo, check out https://github.com/fugroup/modelize
# If you need an ORM, check out https://github.com/fugroup/mongocore

require 'mongo'
require 'active_support'
require 'active_support/core_ext'
require 'request_store'

module Easymongo
  class Query

    attr_accessor :client

    # Set up connection
    def initialize(uri, options)
      self.client = Mongo::Client.new(uri, options)
    end

    # Set up collection, stored in the thread
    def method_missing(name, *args, &block)
      c!; s[:coll] = name; self
    end

    # Set values
    def set(*args)

      # Insert, add oid
      data, values = args.size == 1 ? [{'_id' => oid}, *args] : args

      # Normalize attributes
      data, values = ids(data), ids(values)

      # Using set and unset so we don't store nil in the db
      options = {
        :$set => values.select{|k, v| !v.nil?}, :$unset => values.select{|k, v| v.nil?}
      }.delete_if{|k, v| v.empty?}

      # Update the collection
      result = client[coll].update_one(data, options, :upsert => true)

      # Return result
      Easymongo::Result.new(result)
    end

    # Get values, store cursor in thread
    def get(data = {})
      s[:cursor] = client[coll].find(ids(data)); self
    end

    # Limit
    def limit(n, d = {})
      g!(d); s[:cursor] = cursor.limit(n.to_i); self
    end

    # Skip
    def skip(n, d = {})
      g!(d); s[:cursor] = cursor.skip(n.to_i); self
    end

    # Fields
    def fields(data, d = {})
      g!(d); s[:cursor] = cursor.projection(data); self
    end

    # Sort
    def sort(data, d = {})
      g!(d); s[:cursor] = cursor.sort(data); self
    end

    # Get first
    def first(d = {})
      g!(d); cursor.first.tap{|r| return ed(r) if r; c!}
    end

    # Get last
    def last(d = {})
      g!(d); cursor.sort(:$natural => -1).first.tap{|r| return ed(r) if r; c!}
    end

    # Get all
    def all(d = {})
      g!(d); cursor.to_a.map{|r| ed(r)}.tap{ c!}
    end

    # Count
    def count(d = {})
      g!(d); cursor.count.tap{ c!}
    end

    # Remove
    def rm(data)

      # Optimize data
      data = ids(data)

      # Delete doc
      result = client[coll].delete_one(data)

      # Return result
      Easymongo::Result.new(result).tap{ c!}
    end

    # Make sure data is optimal
    def ids(data)

      # Just return if nothing to do
      return data if data and data.empty?

      # Support passing id as string
      data = {'_id' => data} if !data or data.is_a?(String)

      # Turn all keys to string
      data = data.stringify_keys

      # Convert id to _id for mongo
      data['_id'] = data.delete('id') if data['id']

      # Convert ids to BSON ObjectId
      data.each do |k, v|
        if v.is_a?(String) and v =~ /^[0-9a-fA-F]{24}$/
          data[k] = oid(v)
        end
      end

      # Return data
      data
    end

    # Convert to BSON ObjectId or make a new one
    def oid(v = nil)
      return BSON::ObjectId.new if v.nil?; BSON::ObjectId.from_string(v) rescue v
    end

    private

    # Get the request store
    def s; RequestStore.store; end

    # Clear request store
    def c!; s[:cursor] = s[:coll] = nil; end

    # Run get if no cursor
    def g!(d = {}); get(d) unless cursor; end

    # Get the collection
    def coll; s[:coll]; end

    # Get the cursor
    def cursor; s[:cursor]; end

    # Short cut for creating documents
    def ed(r); Easymongo::Document.new(r); end

  end
end
