$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rufus'
require 'rspec-expectations'
require 'appium_lib'
require 'require_all'
require 'rufus/driver'

World(Rufus::Navigation)
World(Rufus)

 require_rel '/screens'

def selenium
  $rufus
end
