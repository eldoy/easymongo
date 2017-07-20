test 'Features'

doc = Easymongo::Document.new(:test => 1)

is doc.attributes[:test], 1

doc.attributes = {:name => 3, :test => 2, :id => '234'}

is doc.attributes[:name], 3
is doc.attributes[:test], 2
is doc.attributes[:id], '234'

is doc.test, 2

is doc.foobar, nil
