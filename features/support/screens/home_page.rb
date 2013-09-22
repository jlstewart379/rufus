require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :name =>'rufusButton')

  def active?
     view_rufus_view.exists?
    true
  end

end