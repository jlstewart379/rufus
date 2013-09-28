require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :name =>'rufusButton')
  button(:view_show_alert, :name => 'showAlertButton')
  alert(:alert, :name => 'Rufus Alert')


  def active?
     view_rufus_view.exists?
    true
  end

end