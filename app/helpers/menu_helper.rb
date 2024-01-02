module MenuHelper

  def systolic_class
    "app-menu--systolic"
  end

  def is_systolic?
    cookies['menu-systolic'] == 'true'
  end

  def is_active?(compare)
    return false if compare.blank?
    controller = cookies[:controller].split("/").last
    if (compare[controller.to_s.to_sym].present? && compare[controller.to_s.to_sym].include?(cookies[:action].to_s.to_sym)) ||
      (compare.has_key?(controller.to_s.to_sym) && compare[controller.to_s.to_sym].blank?)
      return true
    end

    false
  end

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

  def menu_tag(text, icon, path, **settings)
    icon_class = settings.delete(:icon_class) || {}
    count = settings.delete(:count)
    count_class = settings.delete(:count_class) || {}
    compare = settings.delete(:compare) || {}

    # link option
    activity = is_active?(compare)
    class_list = %w(nav-link tooltipster d-flex align-items-center flex-nowrap gap-2)
    normal_class = %w(link-body-emphasis)
    activity_class = %w(active)
    classes = class_list + (activity ? activity_class : normal_class)
    options = { class: classes, 'data-bs-placement': "right", 'data-bs-title': "#{text}#{" - #{count}" if count.present?}" }
    options.merge!('aria-current': 'page') if activity

    icon_content = menu_icon_tag(icon, icon_class)
    text_content = menu_text_tag(text)
    count_content = menu_count_tag(count, count_class)

    nav_item do
      link_to(path, **options) do
        concat icon_content
        concat text_content
        concat count_content if count.present?
      end
    end
  end

  def toggle_menu_tag(text, icon, **settings, &block)
    icon_class = settings.delete(:icon_class) || {}
    compare = settings.delete(:compare) || {}

    icon_content = menu_icon_tag(icon, icon_class)
    text_content = menu_text_tag(text)

    # btn option
    activity = is_active?(compare)
    class_list = %w(btn btn-toggle rounded border-none tooltipster d-flex align-items-center flex-nowrap gap-2)
    normal_class = %w(collapsed)
    activity_class = %w()
    classes = class_list + (activity ? activity_class : normal_class)

    sleep 0.01 unless compare.keys.present?
    target = compare.keys_sha1
    options = { class: classes, 'data-bs-toggle': "collapse", 'data-bs-target': "##{target}", 'data-bs-parent': '#appMenuMain', 'data-bs-placement': "right", 'data-bs-title': text }
    options.merge!('aria-expanded': 'true') if activity

    button_content = content_tag(:button, **options) do
      concat icon_content
      concat text_content
    end

    # collapse body
    collapse_content = content_tag(:div, nil, id: target, class: "collapse #{'show' if activity}") do
      yield if block_given?
    end

    nav_item do
      concat button_content
      concat collapse_content
    end
  end

end
