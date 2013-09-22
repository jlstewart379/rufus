require 'rufus'

class RufusPage
  include Rufus

  view(:view_main, :name =>'rufusDescription')

  def active?
    view_main_view.exists?
  end

end