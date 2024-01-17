# frozen_string_literal: true

class BreadcrumbComponent < ViewComponent::Base
  renders_many :breadcrumbs, "BreadcrumbItemComponent"

  def initialize(breadcrumbs:)
    @breadcrumbs = breadcrumbs
  end

  class BreadcrumbItemComponent < ViewComponent::Base
    with_collection_parameter :breadcrumb

    def initialize(breadcrumb:, breadcrumb_iteration:)
      @breadcrumb = breadcrumb
      @iteration = breadcrumb_iteration
    end

    def call
      content_tag(:li, class: item_classes, **item_options) do
        if active?
          name
        else
          link_to(name, href)
        end
      end
    end

    def name
      @breadcrumb[:name]
    end

    def href
      @breadcrumb[:href]
    end

    private def item_classes
      active? ? "breadcrumb-item active" : 'breadcrumb-item'
    end

    private def item_options
      active? ? { "aria-current": "page" } : {}
    end

    private def active?
      @iteration.last?
    end

  end

end
