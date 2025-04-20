module ApplicationHelper
  def render_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end
end
