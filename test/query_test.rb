test 'Query'

is !!Easymongo::Query, true

test 'connection'

is !!$db, true

test 'insert'

result = $db.users.set(:name => 'vidar')
id = result.upserted_id.to_s

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
puts result.inspect
puts result.class
is result.n, 1


test 'find'

result = $db.users.get(id).first
is result[:name], 'suong'

result = $db.users.get(:_id => id).first
is result[:name], 'suong'

result = $db.users.get('_id' => id).first
is result[:name], 'suong'

result = $db.users.get('id' => id).first
is result[:name], 'suong'

result = $db.users.get(:name => 'suong').first
is result[:name], 'suong'


test 'find all'

result = $db.users.get(:name => 'suong').all
is result, :a? => Array
is result.first[:name], 'suong'

result = $db.users.get.all
is result, :a? => Array
is result.first[:name], 'suong'

# Setup for first and last
first, last = result[0], result[-1]

test 'find first'

result = $db.users.get.first
puts result.inspect
puts result.class
is result[:_id].to_s, first[:_id].to_s

test 'find last'

result = $db.users.get.last
is result[:_id].to_s, last[:_id].to_s


test 'delete'
