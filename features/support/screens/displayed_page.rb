require 'rufus'

class DisplayedPage

  label(:view_mystery, :name => 'Mystery Label')\

  def active?
    wait_until_displayed view_mystery_view
  end
end