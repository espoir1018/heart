# frozen_string_literal: true

class AsideComponent < ViewComponent::Base
  include Turbo::FramesHelper
  delegate(*[:bs_icon_tag, :app_cookies], to: :helpers)

  def initialize
  end

  def before_render
    @systolic_class = systolic_class if app_cookies['aside-systolic'] == 'true'
  end

  def systolic_class
    "app-aside--systolic"
  end

end
