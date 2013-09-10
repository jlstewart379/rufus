require 'rufus'

class RufusPage
  include Rufus

  view(:view_main, :label=>'rufusDescription')

  def active?
    view_main_view.exists?
  end

end