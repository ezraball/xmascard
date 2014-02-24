module CardsHelper
  def linked_tag_list(lst)
    raw lst.map{|y| link_to(y, tag_path(y), :class => :label)}.join(" ")
  end
  
  def linked_tag_list_with_counts(lst)
    raw lst.map{|y| link_to("#{y} (#{y.count})", tag_path(y.name), :class => :label)}.join(" ")
  end
  
  def glyph(name)
    "#{name}<i class=\"icon-#{name}\"></i>".html_safe
  end
end
