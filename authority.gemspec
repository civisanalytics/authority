# -*- encoding: utf-8 -*-
require File.expand_path('../lib/authority/version', __FILE__)

Gem::Specification.new do |spec|
  spec.license       = 'MIT'
  spec.authors       = ["Civis Analytics"]
  spec.email         = ["opensource@civisanalytics.com"]
  spec.summary       = %q{Authority helps you authorize actions in your Rails app using plain Ruby methods on Authorizer classes.}
  spec.description   = %q{Authority helps you authorize actions in your Rails app. It is ORM-neutral and has very little fancy syntax; just group your models under one or more Authorizer classes and write plain Ruby methods on them.}
  spec.homepage      = "https://github.com/civisanalytics/authority"

  spec.required_ruby_version = '>= 2.1.0', '< 3.4'
  spec.add_runtime_dependency "activesupport", ">= 3.0.0" , "< 8.0"

  spec.add_development_dependency "rspec", ">= 3.4.0", "< 4.0"
  spec.add_development_dependency "pry-byebug", "~> 3.3", "< 4.0"
  spec.add_development_dependency "rubocop", ">= 0.42.0" , "< 2.0.0"

  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.name          = "civis-authority"
  spec.require_paths = ["lib"]
  spec.version       = Authority::VERSION
end
