require 'rufus'

class ExistsPage
  include Rufus

  alert(:alert_delayed, :name => 'This Alert Exists')


  def active?
    exists_after_wait? alert_delayed_view
  end




end