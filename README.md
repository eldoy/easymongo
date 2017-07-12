# Easymongo
Super easy MongoDB Ruby client. This is the way mongo should be.

If you need something closer to pure Mongo, have a look at [Minimongo.](https://github.com/fugroup/minimongo)

We also have [Mongocore](https://github.com/fugroup/mongocore) if you're looking for a full ORM.

### Installation
```
gem install easymongo
```
or add to Gemfile.

### Usage
```ruby
# All commands supported
# https://docs.mongodb.com/ruby-driver/master/quick-start

# Connect
$db = EasyMongo::Query.new(['127.0.0.1:27017'], :database => "easymongo_#{ENV['RACK_ENV']}")

# First
$db.collection.get.first

# Last
$db.collection.get.last

# All
$db.collection.get.all

# Insert / Update
$db.collection.set(:name => name)

# Delete
$db.domains.delete(id)

```

Created and maintained by [Fugroup Ltd.](https://www.fugroup.net) We are the creators of [CrowdfundHQ.](https://crowdfundhq.com)

`@authors: Vidar`
