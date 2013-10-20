require 'rufus'

class ScrollPage
  include Rufus

  view(:view_initial, :name => 'Screen #1')

  def active?
    exists_after_wait? view_initial_view
  end
end