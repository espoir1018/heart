class ApplicationController < ActionController::Base

  before_action :set_menu_cookies, if: ->(c) { !c.request.xhr? && c.request.get? }

  def set_menu_cookies
    cookies.permanent[:controller] = params[:controller]
    cookies.permanent[:action] = params[:action]
  end

end
