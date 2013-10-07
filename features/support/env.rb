$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rufus'
require 'rspec-expectations'
require 'selenium-webdriver'
require 'require_all'
require 'rufus/driver'

World(Rufus::Navigation)
World(Rufus)

 require_rel '/screens'

def selenium
  $driver
end
