require 'rufus'

class EnabledPage
  include Rufus

  text(:view_enabled, :name => 'enabledTextField')
  text(:view_not_enabled, :name => 'notEnabledTextField')

  def active?
    enabled_after_wait? view_enabled_view
  end

end