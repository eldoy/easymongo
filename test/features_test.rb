test 'Features'

doc = Easymongo::Document.new(:test => 1)

t = $db.themes.set(:name => 'Theme')
is t.id, :a? => String

x = $db.users.set(:name => 'Tester', :theme_id => t.id)
is x.id, :a? => String

b = $db.client[:users].find(:_id => BSON::ObjectId.from_string(x.id)).first
is b[:theme_id], :a? => BSON::ObjectId

z = $db.users.first(:theme_id => t.id)
is z.id, :a? => String

test 'Attributes'

is doc.attributes[:test], 1
doc.attributes = {:name => 3, :test => 2, :id => '234'}

is doc.attributes[:name], 3
is doc.attributes[:test], 2
is doc.attributes[:id], '234'

is doc.test, 2
is doc.foobar, nil
