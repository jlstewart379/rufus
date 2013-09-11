require 'rufus/navigation'
require 'rufus/accessors/accessors'
require 'rufus/accessors/view'

module Rufus

  def self.included(cls)
    cls.extend Rufus::Accessors
  end

end