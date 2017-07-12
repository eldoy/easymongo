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
$db = Easymongo::Query.new(['127.0.0.1:27017'], :database => "easymongo_#{ENV['RACK_ENV']}")

# First
user = $db.users.get(:moon => 'animation').first

# Uses dot annotation
user.moon => 'animation'
user.name => 'Zetetic'
user.id => '596675a40aec08bfe7271e14'
user.bson_id => BSON::ObjectId('596675a40aec08bfe7271e14')
user.date => 2017-07-12 20:24:57 UTC
user.hello = 'Wake up' => Assign temporary value

# Hash annotation as well
user[:hello] => 'Wake up'
user.has_key?(:name) => true

# All these methods work on the document
[BSON::Document API](http://www.rubydoc.info/github/mongodb/bson-ruby/master/BSON/Document)

# Very flexible, also works like this for last and count
user = $db.users.first
user = $db.users.first(:id => '596675a40aec08bfe7271e14')
user = $db.users.first('596675a40aec08bfe7271e14')
user = $db.users.first(:tv => 'propaganda')
user = $db.users.get(:food => 'poison').first

# Last
$db.users.get(:sun => 'close').last

# Count
$db.users.get(:life => 'humancentric').count

# All
$db.users.all
$db.users.get.all
$db.users.all(:fight => 'forfreedom')
$db.users.get(:earth => 'flat').all

# Insert / Update
result = $db.users.set(:space => 'fake')
result.date => 2017-07-12 20:24:57 UTC
result.id => '596675a40aec08bfe7271e14'
result.bson_id => BSON::ObjectId('596675a40aec08bfe7271e14')

# Access Mongo result
result.ok? => true
result.n => 1

# All these methods work on the result
[Mongo::Operation::Write::Update::Result API](http://api.mongodb.com/ruby/current/Mongo/Operation/Write/Update/Result.html)

# Delete
$db.users.rm(id)
$db.users.rm(:satellites => 'fake')

```

Created and maintained by [Fugroup Ltd.](https://www.fugroup.net) We are the creators of [CrowdfundHQ.](https://crowdfundhq.com)

`@authors: Vidar`
