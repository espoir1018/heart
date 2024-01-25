# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base

  delegate(*[:bs_icon_tag], to: :helpers)

  def initialize(user:)
    @user = user
  end

end
