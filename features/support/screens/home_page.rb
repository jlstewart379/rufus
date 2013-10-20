require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :name =>'rufusButton')
  view(:view_zilch, :name => 'zilch')
  text(:view_text_box, :name => 'rufusTextBox')
  button(:view_show_alert, :name => 'showAlertButton')
  alert(:alert_rufus, :name => 'Rufus Alert')
  button(:view_exists, :name => 'existsButton')
  button(:view_displayed, :name => 'displayedPageButton')
  button(:view_enabled, :name => 'enabledPageButton')
  button(:view_scroll, :name => 'swipePageButton')
  button(:alert_Ok, :name => 'Ok')
  button(:alert_Cancel, :name => 'Cancel')


  def active?
     view_rufus_view.exists?
    true
  end

end