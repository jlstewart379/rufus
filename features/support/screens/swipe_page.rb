require 'rufus'

class SwipePage
  include Rufus

  view(:view_initial, :name => 'Screen #0')

  def active?
    exists_after_wait? view_initial_view
  end
end