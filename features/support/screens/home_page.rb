require 'rufus'

class HomePage
  include Rufus

  button(:rufus_button, :label=>'rufusButton')



  def active?
      rufus_button_visible?
  end

end