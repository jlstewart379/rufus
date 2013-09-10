require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :label=>'rufusButton')
  #view(:text_rufus, :text=>'RufusButton')

  def active?
     view_rufus_view.exists?
  end

end