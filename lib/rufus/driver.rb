require 'yaml'

module Rufus
  class Driver

    def initialize
      @config = YAML.load_file('config.yml') unless !File.exists?('config.yml')
    end

    def config
      @config
    end
  end
end


#perhaps set or replace a config value?