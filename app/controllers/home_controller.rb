class HomeController < ApplicationController
  def index
  end

  def menu
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(:menu_main, partial: "home/menu")
      end
    end
  end

end
