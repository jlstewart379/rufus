# -*- encoding: utf-8 -*-
#lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "rufus"
  gem.version       = "0.0.0"
  gem.authors       = ["Jeremy Stewart"]
  gem.email         = ["jlstewart379@gmail.com"]
  gem.description   = ""
  gem.summary       = ""
  gem.homepage      = ""

  #gem.files         = `git ls-files`.split($/)
  #gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'page_navigation', '>= 0.7'

  gem.add_development_dependency 'rspec'
  #gem.add_development_dependency 'require_all'
end