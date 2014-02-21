Gem::Specification.new do |gem|
  gem.name          = "rufus"
  gem.version       = "0.9.0"
  gem.authors       = ["Jeremy Stewart"]
  gem.email         = ["jlstewart379@gmail.com"]
  gem.description   = "Page object wrapper for Appium"
  gem.summary       = "Page object wrapper for Appium"
  gem.homepage      = "https://github.com/jlstewart379/rufus"
  gem.require_paths = ["lib"]
  gem.license = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.add_dependency 'page_navigation', '>= 0.7'
  gem.add_development_dependency 'rspec'
end
