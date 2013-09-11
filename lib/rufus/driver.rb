require 'yaml'

module Rufus
  class Driver

    def initialize
      @config = YAML.load 'config.yml' unless !File.exists?('config.yml')
    end

    def config
      @config
    end
  end
end