module ApplicationHelper
  def lettered(index)
    ("A".."Z").first(index+1).last
  end
end
