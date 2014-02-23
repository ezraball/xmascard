module CardsHelper
  def linked_tag_list(lst)
    raw lst.map{|y| link_to(y, tag_path(y), :class => :label)}.join(" ")
  end
end
