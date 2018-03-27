module ApplicationHelper
  def title(default='')
    unless default.blank?
      content_for(:title, default)
    end
    tag.h2 default
  end
end
