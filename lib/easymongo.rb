require 'mongo'

module Easymongo

  # Easymongo MongoDB super easy Ruby library.
  # @homepage: https://github.com/fugroup/easymongo
  # @author:   Vidar <vidar@fugroup.net>, Fugroup Ltd.
  # @license:  MIT, contributions are welcome.

  class << self; attr_accessor :schema; end
end

require_relative 'easymongo/document'
require_relative 'easymongo/result'
require_relative 'easymongo/query'

# Indexing
# $db.client[:profiles].indexes.create_one({:key => 1}, :unique => true)

# Info on MongoDB Driver
# https://docs.mongodb.com/ruby-driver/master/quick-start/
# http://zetcode.com/db/mongodbruby/
# http://recipes.sinatrarb.com/p/databases/mongo
# https://github.com/steveren/ruby-driver-sample-app/blob/master/lib/neighborhood.rb
