require 'rufus/navigation'
require 'rufus/accessors/accessors'
require 'rufus/accessors/view'
require 'rufus/accessors/alert'

module Rufus

  def self.included(cls)
    cls.extend Rufus::Accessors
  end

end