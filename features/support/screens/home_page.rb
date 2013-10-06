require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :name =>'rufusButton')
  button(:view_show_alert, :name => 'showAlertButton')
  alert(:alert_rufus, :name => 'Rufus Alert')
  button(:alert_Ok, :name => 'Ok')
  button(:alert_Cancel, :name => 'Cancel')


  def active?
     view_rufus_view.exists?
    true
  end

end