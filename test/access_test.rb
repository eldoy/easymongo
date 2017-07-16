test 'Access'

email = 'secret@email.com'
$db.users.set(:name => 'Access', :email => email)

user = $db.users.last(:name => 'Access')

is user.id, :a? => String
is user.name, 'Access'
is user.email, email

user = $db.users.get(:name => 'Access').fields(:email => false).first
is user.email, nil

user = $db.users.get(:name => 'Access').fields(:email => 0).first
is user.email, nil

user = $db.users.get(:name => 'Access').skip(1).first
is user, nil

user = $db.users.get(:name => 'Access').skip(0).first
is user.name, 'Access'
