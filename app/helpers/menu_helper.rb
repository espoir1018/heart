module MenuHelper

  def nav_item(&block)
    content_tag :li, class: 'nav-item' do
      yield if block_given?
    end
  end

  def menu_icon_tag(icon, icon_class = {})
    bs_icon_tag(icon, **{ class: 'bi flex-shrink-0', width: 16, height: 16, fill: 'currentColor' }.merge(icon_class))
  end

  def menu_text_tag(text)
    content_tag(:span, text, class: 'flex-grow-1 text-break systolic-none')
  end

  def menu_count_tag(count, count_class = {})
    return nil if count.blank?

    classes = %w(badge flex-shrink-0 systolic-none)
    classes << (count_class.delete(:style) || 'bg-primary')
    classes << (count_class.delete(:type) || 'rounded-pill')

    content_tag(:span, count, class: classes)
  end

  def menu_title(text)
    nav_item do
      content_tag(:span, text, class: 'px-2 fs-6 text-body-tertiary systolic-none')
    end
  end

end
