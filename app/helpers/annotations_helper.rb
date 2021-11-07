# frozen_string_literal: true

module AnnotationsHelper
  include Rails.application.routes.url_helpers

  def default_url_options
    { host: Settings.app_host, protocol: Settings.app_host_protocol }
  end

  def show_link(title, id)
    " <a href=\"/annotations/#{id}\">#{title}</a>"
  end

end
