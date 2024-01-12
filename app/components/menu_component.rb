# frozen_string_literal: true

class MenuComponent < ViewComponent::Base

  def initialize
  end

  class MenuItemComponent < ViewComponent::Base

    include MenuHelper
    delegate(*[:bs_icon_tag, :app_cookies], to: :helpers)

    def initialize(text:, icon:, path:, **options)
      @text = text
      @icon = icon
      @path = path
      @options = options
    end

    def before_render
      @icon_class = @options.delete(:icon_class) || {}
      @count = @options.delete(:count)
      @count_class = @options.delete(:count_class) || {}
      @compare = @options.delete(:compare) || {}
    end

    # render
    def call
      nav_item do
        link_to(@path, **link_options) do
          concat menu_icon_tag(@icon, @icon_class)
          concat menu_text_tag(@text)
          concat menu_count_tag(@count, @count_class) if has_count?
        end
      end
    end

    private def link_options
      activity = is_active?
      class_list = %w(nav-link tooltipster d-flex align-items-center flex-nowrap gap-2)
      normal_class = %w(link-body-emphasis)
      activity_class = %w(active)
      classes = class_list + (activity ? activity_class : normal_class)
      options = { class: classes, 'data-bs-placement': "right", 'data-bs-title': link_tooltipster }
      options.merge!('aria-current': 'page') if activity
      options
    end

    private def link_tooltipster
      arr = [@text]
      arr << @count if has_count?
      arr.compact.join(' - ')
    end

    private def is_active?
      return false if @compare.blank?
      controller = app_cookies[:controller].split("/").last
      if (@compare[controller.to_s.to_sym].present? && @compare[controller.to_s.to_sym].include?(app_cookies[:action].to_s.to_sym)) ||
        (@compare.has_key?(controller.to_s.to_sym) && @compare[controller.to_s.to_sym].blank?)
        return true
      end

      false
    end

    private def has_count?
      @count.present? && @count > 0
    end

  end

  class MenuGroupComponent < ViewComponent::Base

    include MenuHelper
    delegate(*[:bs_icon_tag, :app_cookies], to: :helpers)

    def initialize(text:, icon:, **options)
      @text = text
      @icon = icon
      @options = options
    end

    def before_render
      @icon_class = @options.delete(:icon_class) || {}
      @compare = @options.delete(:compare) || {}
      sleep 0.01 unless @compare.keys.present?
      @target = @compare.keys_sha1
    end

    def call
      nav_item do
        concat button_content
        concat collapse_content
      end
    end

    private def button_content
      content_tag(:button, **button_options) do
        concat menu_icon_tag(@icon, @icon_class)
        concat menu_text_tag(@text)
      end
    end

    private def collapse_content
      content_tag(:div, nil, id: @target, class: "collapse #{'show' if is_active?}") do
        content
      end
    end

    private def button_options
      activity = is_active?
      class_list = %w(btn btn-toggle rounded border-none tooltipster d-flex align-items-center flex-nowrap gap-2)
      normal_class = %w(collapsed)
      activity_class = %w()
      classes = class_list + (activity ? activity_class : normal_class)

      options = { class: classes, 'data-bs-toggle': "collapse", 'data-bs-target': "##{@target}", 'data-bs-parent': '#appMenuMain', 'data-bs-placement': "right", 'data-bs-title': button_tooltipster }
      options.merge!('aria-expanded': 'true') if activity
      options
    end

    private def button_tooltipster
      @text
    end

    private def is_active?
      return false if @compare.blank?
      controller = app_cookies[:controller].split("/").last
      if (@compare[controller.to_s.to_sym].present? && @compare[controller.to_s.to_sym].include?(app_cookies[:action].to_s.to_sym)) ||
        (@compare.has_key?(controller.to_s.to_sym) && @compare[controller.to_s.to_sym].blank?)
        return true
      end

      false
    end

  end

end
