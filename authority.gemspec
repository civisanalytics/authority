# -*- encoding: utf-8 -*-
require File.expand_path('../lib/authority/version', __FILE__)

Gem::Specification.new do |gem|
  gem.license       = 'MIT'
  gem.authors       = ["Nathan Long", "Adam Hunter", "Civis Analytics"]
  gem.email         = ["nathanmlong@gmail.com", "adamhunter@me.com", "opensource@civisanalytics.com"]
  gem.summary       = %q{Authority helps you authorize actions in your Rails app using plain Ruby methods on Authorizer classes.}
  gem.description   = %q{Authority helps you authorize actions in your Rails app. It is ORM-neutral and has very little fancy syntax; just group your models under one or more Authorizer classes and write plain Ruby methods on them.}
  gem.homepage      = "https://github.com/nathanl/authority"

  gem.add_dependency "activesupport", ">= 3.0.0"

  gem.add_development_dependency "rake",  ">= 0.8.7"
  gem.add_development_dependency "rspec", ">= 3.13.0"
  gem.add_development_dependency 'pry-byebug', '>= 3.3'
  gem.add_development_dependency 'rubocop', '>= 0.42.0'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "authority"
  gem.require_paths = ["lib"]
  gem.version       = Authority::VERSION
end
