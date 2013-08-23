require 'rufus'

class HomePage
  include Rufus

  view(:rufus_button, :label=>'rufusButton')



  def active?
     rufus_button_view.exists?
  end

end