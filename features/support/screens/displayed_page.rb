require 'rufus'

class DisplayedPage
  include Rufus

  label(:view_mystery, :name => 'Mystery Label')
  label(:view_invisible, :name => 'Invisible Label')

  def active?
    displayed_after_wait? view_mystery_view
  end
end