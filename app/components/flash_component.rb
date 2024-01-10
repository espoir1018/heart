# frozen_string_literal: true

class FlashComponent < ViewComponent::Base

  def initialize(flash:)
    @flash = flash
  end

  def flash_type
    case @flash[0]
    when 'notice', 'success' then 'success'
    when 'alert', 'error', 'danger' then 'error'
    when 'warn', 'warning' then 'warning'
    when 'info' then 'info'
    else 'info'
    end
  end

  def flash_content
    @flash[1]
  end

end
