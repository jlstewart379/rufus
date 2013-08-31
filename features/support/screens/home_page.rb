require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :label=>'rufusButton')


  def active?
     rufus_view.exists?
  end

end