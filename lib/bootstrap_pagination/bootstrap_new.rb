require "will_paginate/view_helpers/action_view"
require "bootstrap_pagination/bootstrap_renderer"

module BootstrapPagination
  # A custom renderer class for WillPaginate that produces markup suitable for use with Twitter Bootstrap.
  class BootstrapNew < WillPaginate::ActionView::LinkRenderer
    include BootstrapPagination::BootstrapRendererNew
  end
end
