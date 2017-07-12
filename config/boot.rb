require 'bundler/setup'
Bundler.require(:default, :development)

MODE = ENV['RACK_ENV'] || 'development'

require './lib/easymongo.rb'

Mongo::Logger.logger.level = ::Logger::FATAL

# Connect
$db = Easymongo::Query.new(['127.0.0.1:27017'], :database => "easymongo_#{MODE}")

include Futest::Helpers
