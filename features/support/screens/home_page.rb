require 'rufus'

class HomePage
  include Rufus

  view(:view_rufus, :label=>'rufusButton')
  view(:text_rufus, :text=>'RufusButton')

  def active?
     rufus_view.exists?
  end

end