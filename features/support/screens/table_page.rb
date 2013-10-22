require 'rufus'

class TablePage
  include Rufus

  table(:view_ascending, :name => 'ascending')
  table(:view_descending, :name => 'descending')
  table(:view_unsorted, :name => 'notSorted')

  def active?
    exists_after_wait? view_ascending_view
  end

end