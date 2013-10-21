require 'rufus'

class TablePage
  include Rufus

  table(:view_sorted, :name => 'table')
  table(:view_unsorted, :name => 'unsorted')

  def active?
    exists_after_wait? view_sorted_view
  end

end