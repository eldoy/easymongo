test 'Features'

doc = Easymongo::Document.new(:test => 1)

test 'Attributes'

is doc.attributes[:test], 1
doc.attributes = {:name => 3, :test => 2, :id => '234'}

is doc.attributes[:name], 3
is doc.attributes[:test], 2
is doc.attributes[:id], '234'

is doc.test, 2

is doc.foobar, nil

test 'Defaults'

$db.defaults = {:data => 'hello'}
$db.users.set(:name => 'Defaults')
user = $db.users.last(:name => 'Defaults')
is user.data, 'hello'

is $db.defaults, :a? => Hash
is $db.defaults[:data], 'hello'
