require 'rufus'

class LabelAPage
  include Rufus

  label(:view_a, :name => 'Label A Page')

  def active?
    exists_after_wait? view_a_view
  end
end