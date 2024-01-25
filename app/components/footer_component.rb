# frozen_string_literal: true

class FooterComponent < ViewComponent::Base

  delegate(*[:bs_icon_tag], to: :helpers)

  def initialize(user:)
    @user = user
  end

end
