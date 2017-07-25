Gem::Specification.new do |s|
  s.name        = 'easymongo'
  s.version     = '0.0.8'
  s.date        = '2017-07-25'
  s.summary     = "Super Easy MongoDB client"
  s.description = "The way MongoDB for Ruby should be, can't get easier than this"
  s.authors     = ["Fugroup Limited"]
  s.email       = 'vidar@fugroup.net'

  s.add_runtime_dependency 'mongo', '>= 2.2'
  s.add_runtime_dependency 'activesupport', '>= 4.0'
  s.add_runtime_dependency 'request_store', '>= 1.2'
  s.add_development_dependency 'futest', '>= 0'

  s.homepage    = 'https://github.com/fugroup/easymongo'
  s.license     = 'MIT'

  s.require_paths = ['lib']
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
end
