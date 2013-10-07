require 'rufus'

class ExistsPage
  include Rufus

  alert(:alert_delayed, :name => 'This Alert Exists')


  def active?
    wait_until_exists alert_delayed_view
  end




end