test 'Query'

is !!Easymongo::Query, true

test 'connection'

is !!$db, true

test 'insert'

result = $db.users.set(:name => 'vidar')
id = result.id

is result.n, 1
is id, :a? => String
is id.size, 24

test 'update'

result = $db.users.set(id, :name => 'suong')
is result.n, 1

result = $db.users.set({:_id => id}, :name => 'suong')
is result.n, 1

result = $db.users.set({'_id' => id}, :name => 'suong')
is result.n, 1

result = $db.users.set({'id' => id}, :name => 'suong')
is result.n, 1

result = $db.users.set({:id => id}, :name => 'suong')
is result.n, 1


test 'find'

result = $db.users.get(id).first
is result.name, 'suong'

result = $db.users.first(id)
is result.name, 'suong'

result = $db.users.get(:_id => id).first
is result.name, 'suong'

result = $db.users.get('_id' => id).first
is result.name, 'suong'

result = $db.users.get('id' => id).first
is result.name, 'suong'

result = $db.users.get(:name => 'suong').first
is result.name, 'suong'

result = $db.users.get(nil).first
is result, nil


test 'find all'

result = $db.users.get(:name => 'suong').all
is result, :a? => Array
is result.first.name, 'suong'

result = $db.users.get.all
is result, :a? => Array
is result.first.name, 'suong'

# Setup for first and last
first, last = result[0], result[-1]

test 'find first'

result = $db.users.get.first
is result.id, first.id

test 'find last'

result = $db.users.get.last
is result.id, last.id

result = $db.users.last
is result.id, last.id

result = $db.users.last(:name => 'suong')
is result.id, last.id

test 'delete'

id = $db.users.set(:name => 'del').id
result = $db.users.rm(id)

is result.n, 1

r = $db.users.get(id).first

is r, nil

test 'count'

result = $db.users.count
total = $db.users.get.all.size
is result, :a? => Integer
is result, total

result = $db.users.get.count
is result, :a? => Integer
is result, total

$db.users.set(:name => 'count')
result = $db.users.count(:name => 'count')
is result, :a? => Integer
is result, 1

result = $db.users.get(:name => 'count').count
is result, :a? => Integer
is result, 1

test 'ne'

count = $db.users.count
is count > 1

r = $db.users.first
result = $db.users.get(:id => {:$ne => r.id}).first
is result, :ne => nil

result = $db.users.first(:id => {:$ne => r.id})
is result, :ne => nil

result = $db.users.first(:id => {:$ne => BSON::ObjectId.from_string(r.id)})
is result, :ne => nil
