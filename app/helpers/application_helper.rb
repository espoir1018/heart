module ApplicationHelper

  def bs_icon_tag(icon, **options)
    content_tag :svg, options do
      content_tag :use, nil, 'xlink:href': "bootstrap-icons.svg##{icon}"
    end
  end

  def toastr_flash_tag
    turbo_frame_tag :toastr_flash, target: '_top', class: "app-toastr" do
      render(FlashComponent.with_collection(flash.to_a))
    end
  end

  def app_cookies
    cookies
  end


end
