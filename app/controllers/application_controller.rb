class ApplicationController < ActionController::Base

  before_action :set_menu_cookies

  def set_menu_cookies
    return unless %w(index new edit show).include?(params[:action].to_s)

    cookies.permanent[:controller] = params[:controller]
    cookies.permanent[:action] = params[:action]
  end

end
