require 'rufus'

class LabeledPage
  include Rufus

  image(:view_image, :label => 'imageview_its_me')

  def active?
    sleep 0.3
    true
  end




end