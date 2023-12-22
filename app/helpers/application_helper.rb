module ApplicationHelper

  def bs_icon_tag(icon, **options)
    content_tag :svg, options do
      content_tag :use, nil, 'xlink:href': "bootstrap-icons.svg##{icon}"
    end
  end

end
