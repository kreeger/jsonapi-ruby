# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jsonapi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Benjamin Kreeger"]
  gem.email         = ["ben@kree.gr"]
  gem.description   = "A Ruby interface to the Bukkit/Minecraft JSONAPI plugin."
  gem.summary       = "A Ruby interface to the Bukkit/Minecraft JSONAPI plugin."
  gem.homepage      = "http://ben.kree.gr"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jsonapi"
  gem.require_paths = ["lib"]
  gem.version       = JSONAPI::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-yard'
  gem.add_development_dependency 'redcarpet'
  gem.add_development_dependency 'ruby_gntp'
  gem.add_development_dependency 'debugger'

  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'faraday_middleware'
  gem.add_runtime_dependency 'activesupport'
end
